function [wnm]=w_rec(wnm_basic,recn)                               
% [wnm]=w_rec(wnm_basic,recn)                                
% a static method from class named @sol_filter
% usage:sol_filter.w_rec         
%**************************************************************************
% In   : 
%       wnm_basic     [(Nmax+2)*(Nmax+1)/2 x 1]   
%                      basic weighted coefficients storaged as clm-format   
%       recn          [1x1] reconstructive number (int)
% Out  :    
%       wnm           [(Nmax+2)*(Nmax+1)/2 x 1]   
%                     reconstructive weighted coefficients storaged as clm-format
%----------------------------------------------------------------------------

% Authors: Karl Jian
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
% Ref: Jian, Guangyu, Chuang Xu, Fang Zou, and Bo Huang. 2023. 
% ‘A Novel GRACE Reconstructive Filter to Extract the Mass Changes in Madagascar’. 
% GEOPHYSICAL JOURNAL INTERNATIONAL 235(2): 1493–1503.
%**************************************************************************
%
    wnm=1-(1-wnm_basic).^recn;
end
