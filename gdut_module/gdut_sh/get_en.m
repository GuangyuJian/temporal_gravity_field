function [en]=get_en(maxn)                               
% [en]=get_en(maxn)  
% this function ouput the length of a vector for a given maximum degree
% (i.e., truncated degree)
%----------------------------------------------------------------------------
% In   : maxn   [1x1]   maximum degree
%
% Out  : en     [1x1]  total number of vecr 
%----------------------------------------------------------------------------
                     
% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-11
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 
%**************************************************************************
%Ref:
%**************************************************************************                                   
   en=1+(maxn+3)*(maxn)/2;                                                    
end

