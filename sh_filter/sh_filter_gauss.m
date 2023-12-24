function [wnm]=sh_filter_gauss(max_degree,rf,radius_earth)                               
%                              
%**************************************************************************
% In   : 
%       max_degree      [1x1] maximum  degree (int)
%       rf              [1x1] radius of Gaussian smoothing (km)
%       radius_earth    [1x1] radius of earth (km)                     
% Out  :    
%       wnm     [(Nmax+2)*(Nmax+1)/2 x 1]   
%               weighted coefficients storaged as clm-format
%----------------------------------------------------------------------------

% Authors: Karl Jian
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
% Ref:  Chambers et al.JGR, 2006, 
% Observing seasonal steric sea level variations with GRACE and satellite altimetry
% eq.(4)
%**************************************************************************
%
% r1=rf;%%Unit:km
% weights per degree

for n=0:max_degree
    wn(n+1)=exp(-((n)*rf/radius_earth)^2/(4*log(2)));
end

% the weights are sorted by degree n, then by order m.
for n=0:max_degree
    st=2+(n+2)*(n-1)/2;
    for m=0:n
        wnm(st+m,1)=wn(n+1);
    end
end                   

end
% Recursive algorithm in the work of  Wahr et. al. (1998) equation (34)
% not recommended since its instabilities beyond degree 50.
% r1=radius1*1000;%%Unit:km
% b1=log(2)/(1-cos(r1/R));
% Wl(1)=1;
% Wl(2)=(1+exp(-2*b1))/(1-exp(-2*b1))-1/b1;
% for l=1:(Lmax-1)
%     Wl(l+2)=-(2*l+1)/b1*Wl(l+1)+Wl(l);
% end
