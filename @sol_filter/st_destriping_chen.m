function scnew = st_destriping_chen(sc,type)

% Do destriping to spherical harmonic coefficients using Chen methods
% References:   Chen P3M6 2007 GRACE detects coseismic and postseismic deformation from the Sumatra-Andaman earthquake
%               Chen P4M6 2009 2005 drought event in the Amazon River basin as measured by GRACE and estimated by climate models
% 
% INPUT:
%   sc       C_lm & S_lm in SC format (original spherical harmonic coefficients, /S|C\, (L+1)x(2L+1))
%   type     destriping methods, options: CHENP3M6,CHENP4M6
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

poly_ord = 2;


if strcmp(type,'chenp3m6')
    poly_ord    = 3;
    ms   = 6;
elseif strcmp(type,'chenp4m6')
    poly_ord    = 4;
    ms   = 6;
else
    error('The Chen Destriping method is wrong!');
end
me=maxn-10;

sc_s = zeros(maxn+1,2*maxn+1);

for mm = ms:me
    
    % for mm = start_ord:me
    clm_col_s = zeros(maxn+1,1);
    slm_col_s = zeros(maxn+1,1);
    
        % even(odd) degree
        n=mm:2:maxn;
        clm = sc(n+1,maxn+1+mm)';
        slm = sc(n+1,maxn+1-mm)';
        % fit a  polynomial
        poly_clm = polyfit(n,clm,poly_ord);
        poly_slm = polyfit(n,slm,poly_ord);
        
        clm_col_s(n+1,1) = polyval(poly_clm,n);
        slm_col_s(n+1,1) = polyval(poly_slm,n);
               
        % odd(even) degree
        n=mm+1:2:maxn;
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


