
function [gc]=scf_mc2gc(mc,maxn)
% [mc]=scf_gdc2gc(gc,maxn)                            
%----------------------------------------------------------------------------
% In   :   mc   [1xen]  mass coefficients
%                       storage as degree-dependent  vecc/vecs
%          maxn [1x1]   maximum degree                    
% Out  :   gc   [1xen]  geopotential coefficients
%                       storage as degree-dependent  vecc/vecs                 
%----------------------------------------------------------------------------
                                              
% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-23
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************

% kn=math_Lovenum(maxn);
load('HanWahrLoveNumbers.mat');
ae        =  6378136.3;
rho_w = 1000;       % density of water kg/m^3
rho_ave = 5517;     % average density of the earth kg/m^3

dens = ae*rho_ave/(3);
k(2) = 0.021;

for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    en=st+n;
        factor(st:en,1)=dens*(2*n+1)/(k(n+1)+1);
%     factor(st:en,1)=(1/kn(t:en,1))/dens;
end
gc=mc(:)./factor(:);

end