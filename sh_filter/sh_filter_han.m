function [wnm,w_han]=sh_filter_han(max_degree,r0,r1,m1,R)                               
%                              
%**************************************************************************
% In   :    
%       max_degree      [1x1] maximum  degree (int)
%       r0;             [1 x 1]  parameter of han smoothing, unit: km 
%       r1;             [1 x 1]  parameter of han smoothing, unit: km 
%       m1;             [1 x 1]  parameter of han smoothing, unit: km 
%       radius_earth    [1x1] radius of earth (km)                                             
% Out  :    
%       wnm     [(Nmax+2)*(Nmax+1)/2 x 1]   
%               weighted coefficients storaged as clm-format
%       wcs     [(Nmax+1)  x  (Nmax+1)/2] 
%               weighted coefficients storaged as cs-format
%----------------------------------------------------------------------------
% Authors: Karl Jian
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
%**************************************************************************
% Ref: Han, SC et al. 2005. 
% ‘Non-Isotropic Filtering of GRACE Temporal Gravity 
% for Geophysical Signal Enhancement’. 
% GEOPHYSICAL JOURNAL INTERNATIONAL 163(1): 18–25.
%**************************************************************************  

if nargin==0
    disp('defval the parameter in Han')
    r0=500;
    r1=1000;
    m1=15;
end

for m=0:max_degree
    rtemp=(r1-r0)/m1*m+r0;
    r_ml=rtemp*1000;
    for l=0:max_degree
        
        if m>l
            w_han(l+1,m+1)=nan;
        else
            w_han(l+1,m+1)=exp(-((l)*r_ml/R)^2/(4*log(2)));
        end
    end
end

for l=0:max_degree
    st=2+(l+2)*(l-1)/2;
    for m=0:l
        wnm(st+m,1)=w_han(l+1,m+1);
    end
end
                             
                              
                              
end

