function [self2]=ts_res(self)                               
%                              
%----------------------------------------------------------------------------
% In   :    
%                              
% Out  :    
%                              
%----------------------------------------------------------------------------
                              
                              
% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-04
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
       
t=self.time;
tws=self.value;
% [ou]=fit_harmonic_ts_4months(t,tws);   
[residual2]=get_residual(t,tws);
self2=self-self;
self2.value=residual2;                                    
                              
                              
                              
end

