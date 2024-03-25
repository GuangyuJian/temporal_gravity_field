function scnew = st_destriping_duan(pair1,pair2,r,gamma,p,K,A,sc)

% Do destriping to spherical harmonic coefficients using Duan methods
% References:   Duan 2009 On the postprocessing removal of correlated errors in GRACE temporal gravity field solutions
%
% INPUT:
%   pair1, pari2    the degree-order pairs defining the unchanged portion
%                   of SH coefficients, first point is (pair1,0), the other
%                   one is (pair2, pair2)
%   r               empitical parameter in equation (2) in Duan et al. 2009 JoG
%   gamma           empitical parameter in equation (3) in Duan et al. 2009 JoG
%   p               empitical parameter in equation (3) in Duan et al. 2009 JoG
%   K               empitical parameter in equation (3) in Duan et al. 2009 JoG
%   A               empitical parameter in equation (3) in Duan et al. 2009 JoG
%   sc              C_lm & S_lm in SC format (original spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
%
% OUTPUT:
%   scnew           C_lm & S_lm in SC format (destriped spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
%
% FENG Wei 22/03/2015
% State Key Laboratory of Geodesy and Earth's Dynamics
% Institute of Geodesy and Geophysics, Chinese Academy of Sciences
% fengwei@whigg.ac.cn


[rows,cols]=size(sc);
maxn=rows-1;


poly_ord = 2;
me=maxn-8;
ne=maxn;



sc_s = zeros(maxn+1,2*maxn+1);
% sc_s(me+1:ne+1,:) = sc(me+1:ne+1,:);

% Do the calculation for each degree separately

for mm = pair2:me-1

    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);



    llvec = mm:ne;


    for ll = llvec

        % nsmooth is filter window
        %     nsmooth = round(30*exp(-mm/10)+1);
        tmp=((1-gamma)*mm.^p+gamma*ll.^p).^(1/p);
        nsmooth = round(A*exp(-tmp/K)+1);
        if nsmooth < 5
            nsmooth = 5;
        end

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

for mm = 0:pair2-1

    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);

    beta = (pair2-pair1)/pair2.^r;
    start_deg = round(pair1+beta*mm.^r)+1;
    llvec = start_deg:ne;

    for ll = llvec
        % nsmooth is filter window
        %     nsmooth = round(30*exp(-mm/10)+1);
        tmp=((1-gamma)*mm.^p+gamma*ll.^p).^(1/p);
        nsmooth = round(A*exp(-tmp/K)+1);
        if nsmooth < 5
            nsmooth = 5;
        end
        % form the vector n, it will contain odd degrees if ll = odd, it
        % will contain even degrees if ll = even.
        if (ll-(nsmooth-1)<=start_deg) % on the left of
            if (mod(ll,2)==0) % ???
                if (mod(start_deg,2)==0)
                    n = start_deg:2:start_deg+(nsmooth-1)*2;    % even degrees starting at mm
                else
                    n = start_deg+1:2:start_deg+1+(nsmooth-1)*2;% even degrees starting at mm+1
                end
            else % ???
                if (mod(start_deg,2)==0)
                    n = start_deg+1:2:start_deg+1+(nsmooth-1)*2;% odd degrees starting at mm+1
                else
                    n = start_deg:2:start_deg+(nsmooth-1)*2;    % odd degrees starting at mm
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
                    n =ll-nsmooth+1:2:ll+nsmooth-1;  % odd or even degree taken care of
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

        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';

        % fit a second order polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        clm_col_s(ll+1,1) = polyval(poly_clm,ll);
        slm_col_s(ll+1,1) = polyval(poly_slm,ll);

    end
    sc_s(:,maxn+1+mm) = clm_col_s;
    sc_s(:,maxn+1-mm) = slm_col_s;

end

scnew = sc-sc_s;
end

