function [gdc]=scf_gc2gdc(gc,maxn)
% [gdc]=scf_gc2gdc(gc,maxn)                             
%----------------------------------------------------------------------------
% In   :   gc   [1xen]  geopotential coefficients
%                       storage as degree-dependent  vecc/vecs
%          maxn [1x1]   maximum degree                    
% Out  :   gdc   [1xen]  gravity disturbance coefficients
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
ae        =  6378136.3;
rho_w = 1000;                   % density of water kg/m^3
rho_ave = 5517;                 % average density of the earth kg/m^3
GM        =  3.986004415e14;    % [m^3 / s^2]

for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    en=st+n;
    factor(st:en,1)=(n+1)*GM/ae/ae*1e8; %ugal
end
gdc=factor(:).*gc(:);
end
