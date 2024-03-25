function scnew = st_destriping_chambers(sc,type)

% Do destriping to spherical harmonic coefficients using Chambers methods
% References:   Chambers 2007 Converting Release-04 Gravity Coefficients into Maps of Equivalent Water Thickness 
%               Chambers 2012 Evaluation of Release-05 GRACE time-variable
%               gravity coefficients over the Ocean, Ocean Science Discussions
% 
% INPUT:
%   sc       C_lm & S_lm in SC format (original spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
%   type     destriping methods, options: CHAMBERS2007,CHAMBERS2012
%
% OUTPUT:
%   scnew    C_lm & S_lm in CS format (destriped spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
% 
% FENG Wei 22/03/2015
% State Key Laboratory of Geodesy and Earth's Dynamics
% Institute of Geodesy and Geophysics, Chinese Academy of Sciences
% fengwei@whigg.ac.cn


% sc represents the original sphere harmonics before destriping
[rows,cols] = size(sc);
maxn=rows-1;

if strcmp(type,'chambers2007') % P5M12
    poly_ord    = 5;
    ns   = 12;
elseif strcmp(type,'chambers2012') % P4M15
    poly_ord    = 4;
    ns   = 15;
else
    error('The Chambers Destriping method is wrong!');
end

ne     = maxn;
ms   = 2;
me     = 40; % This parameter is NOT confirmed for d/o 96 files!

sc_s = zeros(maxn+1,2*maxn+1);

for mm = ms:me
    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);
    
    if (mm>ns)
        %         llvec = [mm:ne];
        % even(odd) degree
        n=mm:2:ne;
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';
        % fit a  polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        
        clm_col_s(n+1,1) = polyval(poly_clm,n);
        slm_col_s(n+1,1) = polyval(poly_slm,n);
        
        % odd(even) degree
        n=mm+1:2:ne;
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';
        % fit a  polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        
        clm_col_s(n+1,1) = polyval(poly_clm,n);
        slm_col_s(n+1,1) = polyval(poly_slm,n);
        
        
        sc_s(:,maxn+1+mm) = clm_col_s;
        sc_s(:,maxn+1-mm) = slm_col_s;
    else
        %         llvec = [ns:ne];
        % even(odd) degree
        n=ns:2:ne;
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';
        % fit a  polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        
        clm_col_s(n+1,1) = polyval(poly_clm,n);
        slm_col_s(n+1,1) = polyval(poly_slm,n);
        
        % odd(even) degree
        n=ns+1:2:ne;
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';
        % fit a  polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        
        clm_col_s(n+1,1) = polyval(poly_clm,n);
        slm_col_s(n+1,1) = polyval(poly_slm,n);
        
        
        sc_s(:,maxn+1+mm) = clm_col_s;
        sc_s(:,maxn+1-mm) = slm_col_s;
        
    end
end

for mm = 0:ms-1
    
    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);
    
    % even(odd) degree
    n=ns:2:ne;
    clm = sc(n+1,maxn+1+mm)';
    slm = sc(n+1,maxn+1-mm)';
    % fit a  polynomial
    poly_clm = polyfit(n,clm,poly_ord);
    poly_slm = polyfit(n,slm,poly_ord);
    
    clm_col_s(n+1,1) = polyval(poly_clm,n);
    slm_col_s(n+1,1) = polyval(poly_slm,n);
    
    % odd(even) degree
    n=ns+1:2:ne;
    clm = sc(n+1,maxn+1+mm)';
    slm = sc(n+1,maxn+1-mm)';
    % fit a  polynomial
    poly_clm = polyfit(n,clm,poly_ord);
    poly_slm = polyfit(n,slm,poly_ord);
    
    clm_col_s(n+1,1) = polyval(poly_clm,n);
    slm_col_s(n+1,1) = polyval(poly_slm,n);
    
    sc_s(:,maxn+1+mm) = clm_col_s;
    sc_s(:,maxn+1-mm) = slm_col_s;

end

scnew = sc-sc_s;

% for mm = me+1:maxn
%     scnew(:,maxn+1+mm) = 0.;
%     scnew(:,maxn+1-mm) = 0.;
% end

end

