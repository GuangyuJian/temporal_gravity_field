function scnew = st_destriping_swenson(sc)

% Do destriping to spherical harmonic coefficients using Swenson methods
% References:   Swenson 2006 Post-processing removal of correlated errors in GRACE data
%               Duan 2009 On the postprocessing removal of correlated errors in GRACE temporal gravity field solutions
%
% INPUT:
%   sc              C_lm & S_lm in SC format (original spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
%
% OUTPUT:
%   scnew           C_lm & S_lm in CS format (destriped spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
%
% FENG Wei 05/09/2015
% State Key Laboratory of Geodesy and Earth's Dynamics
% Institute of Geodesy and Geophysics, Chinese Academy of Sciences
% fengwei@whigg.ac.cn

[rows,cols]=size(sc);
maxn=rows-1;

ns   = 5;
ne     = maxn;
ms   = 5;
me     = maxn-8;

% using a quadratic polynomial Swenson and Wahr (GRL 2006)
poly_ord = 2;

% the fitted values of sphere harmonics, which will be removed
sc_s = zeros(maxn+1,2*maxn+1);

% unchanged portion of sphere harmonics
% sc_s(me+1:ne+1,:) = sc(me+1:ne+1,:);

% Do the calculation for each order separately
for mm = ms:me

    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);

    % nsmooth is filter window, refer to Duan et al. (2009)
    nsmooth = round(30*exp(-mm/10)+1);
    if nsmooth < 5
        nsmooth = 5;
    end

    if (maxn==96&&mm==88) % for new CSR RL05 GSM d/o 96
        llvec = [88,90,92,94,96];
    elseif (maxn==60&&mm==52) % for old CSR RL05 GSM d/o 60
        llvec = [52,54,56,58,60];
    elseif (maxn==90&&mm==82) % for JPL/GFZ RL05 GSM d/o 60
        llvec = [82,84,86,88,90];
    else
        if (mm>ns)
            llvec = mm:ne;
        else
            llvec = ns:ne;
        end
    end

    for ll = llvec
        % form the vector n, it will contain odd/even degrees if ll = odd/even
        if (ll-(nsmooth-1)<=mm) % on the left of
            if (mod(ll,2)==0) % ???
                if (mod(mm,2)==0)
                    n = mm:2:mm+(nsmooth-1)*2;    % even degrees starting at mm
                else
                    n = mm+1:2:mm+1+(nsmooth-1)*2;% even degrees starting at mm+1
                end
            else % ???
                if (mod(mm,2)==0)
                    n = mm+1:2:mm+1+(nsmooth-1)*2;% odd degrees starting at mm+1
                else
                    n = mm:2:mm+(nsmooth-1)*2;    % odd degrees starting at mm
                end
            end
        else
            if mod(nsmooth,2)==0                        % nsmooth is even
                if ll+nsmooth <= ne
                    % option1: n = [ll-nsmooth:2:ll+nsmooth-2];    % add 1 point more before
                    % option2:
                    n = ll-nsmooth+2:2:ll+nsmooth;    % 1 point more after
                else
                    if mod(ll,2)==0    % even degrees
                        n = ne-(nsmooth-1)*2:2:ne;    %
                    else                % odd degrees
                        n = ne-1-(nsmooth-1)*2:2:ne-1;    %
                    end
                end
            else                                    % nsmooth is odd
                if (ll+nsmooth-1 <= ne)
                    n = ll-nsmooth+1:2:ll+nsmooth-1;  % odd or even degree taken care of
                else
                    if mod(ll,2)==0    % even degree
                        n = ne-(nsmooth-1)*2:2:ne;    %
                    else                % odd degree
                        n = ne-1-(nsmooth-1)*2:2:ne-1;    %
                    end
                end
            end
        end
        % Load a vector for order mm with the coefficients for odd or even
        % degrees in the window.
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';

        % fit a second order polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        clm_col_s(ll+1,1) = polyval(poly_clm,ll);
        slm_col_s(ll+1,1) = polyval(poly_slm,ll);

    end
    %     plot([1:2:maxn+1],clm_col_s(1:2:maxn+1),'r'); hold on
    %     plot([2:2:maxn],clm_col_s(2:2:maxn),'b')
    sc_s(:,maxn+1+mm) = clm_col_s;
    sc_s(:,maxn+1-mm) = slm_col_s;

end

% ???????
for mm = 0:ms-1
    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);


    % nsmooth is filter window
    nsmooth = round(30*exp(-mm/10)+1);
    if nsmooth < 5
        nsmooth = 5;
    end



    llvec = ns:ne;

    for ll = llvec

        % form the vector n, it will contain odd degrees if ll = odd, it
        % will contain even degrees if ll = even.
        if (ll-(nsmooth-1)<=ns) % on the left of
            if (mod(ll,2)==0) % ???
                if (mod(ns,2)==0)
                    n = ns:2:ns+(nsmooth-1)*2;    % even degrees starting at mm
                else
                    n = ns+1:2:ns+1+(nsmooth-1)*2;% even degrees starting at mm+1
                end
            else % ???
                if (mod(ns,2)==0)
                    n = ns+1:2:ns+1+(nsmooth-1)*2;% odd degrees starting at mm+1
                else
                    n = ns:2:ns+(nsmooth-1)*2;    % odd degrees starting at mm
                end
            end
        else
            if mod(nsmooth,2)==0                        % nsmooth even
                if ll+nsmooth <= ne
                    %                     n = [ll-nsmooth:2:ll+nsmooth-2];    % 1 point more before
                    % other option:
                    n = ll-nsmooth+2:2:ll+nsmooth;    % 1 point more after
                else
                    if mod(ll,2)==0    % even degrees
                        n = ne-(nsmooth-1)*2:2:ne;    %
                    else                % odd degrees
                        n = ne-1-(nsmooth-1)*2:2:ne-1;    %
                    end
                end
            else                                    % nsmooth odd
                if (ll+nsmooth-1 <= ne)
                    n = ll-nsmooth+1:2:ll+nsmooth-1;  % odd or even degree taken care of
                else
                    if mod(ll,2)==0    % even degree
                        n = ne-(nsmooth-1)*2:2:ne;    %
                    else                % odd degree
                        n = ne-1-(nsmooth-1)*2:2:ne-1;    %
                    end
                end
            end
        end


        n(logical(n>maxn))=[];
        n(logical(n<0))=[];

        % Load a vector for order mm with the coefficients for odd or even
        % degrees in the window.
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';

        % fit a second order polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        clm_col_s(ll+1,1) = polyval(poly_clm,ll);
        slm_col_s(ll+1,1) = polyval(poly_slm,ll);
        %         polyval(poly_slm,ll)

    end
    %     plot([1:2:maxn+1],clm_col_s(1:2:maxn+1),'r'); hold on
    %     plot([2:2:maxn],clm_col_s(2:2:maxn),'b')
    sc_s(:,maxn+1+mm) = clm_col_s;
    sc_s(:,maxn+1-mm) = slm_col_s;

end
scnew = sc-sc_s;%Remove fitted values from original sphere harmonics
end

