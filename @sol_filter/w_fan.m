function [wnm]=w_fan(max_degree,rf,radius_earth)                               
% [wnm]=w_fan(max_degree,rf,radius_earth)                                   
% a static method from class named @sol_filter
% usage:sol_filter.w_fan
%**************************************************************************
% In   : 
%       max_degree      [1x1] maximum  degree (int)
%       rf              [1x1] radius of Fan smoothing (km)
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
% Ref:  Zhang, Zi-Zhan, B. F. Chao, Yang Lu, and Hou-Tse Hsu. 2009. 
% ‘An Effective Filtering for GRACE Time-Variable Gravity: Fan Filter’. 
% GEOPHYSICAL RESEARCH LETTERS.
%**************************************************************************

% r1=rf*1000;%%Unit:km
% weights per degree

for n=0:max_degree
    wn(n+1)=exp(-((n)*rf/radius_earth)^2/(4*log(2)));
end

% the weights are sorted by degree n, then by order m.
for n=0:max_degree
    st=2+(n+2)*(n-1)/2;
    for m=0:n
        wnm(st+m,1)=wn(n+1)*wn(m+1);
    end
end                                               
                              
                              
end

