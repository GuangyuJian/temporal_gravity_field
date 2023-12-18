function [outc,outs,nm]=storage_cs2vec(in,ordflag)                               
%                              
% CS2VEC rearranges a field of spherical harmonic coefficients in 
% cs- or sc-format to a vector shape. The order will be:
%
% CASE I: degree-wise (default)
%        nm   = [0    1    1    2    2    2    3    3    3    3  ...
%                0    0    1    0    1    2    0    1    2    3  ...]
% CASE II: order-wise
%        nm   = [0    1    2    3    1    2    3    2    3    3  ...
%                0    0    0    0    1    1    1    2    2    3  ...]
%
% IN: 
%    in ....... [n,m]   input in cs- or sc-format
%    ordflag .. [bool]  false = degree-wise ordering (default)
%                       true  = order-wise ordering 
% 
% OUTPUT:
%    nm ...... ordering vector                                      [2,k]  
%              maximum degree - degree-wise ordering is assumed     [1,1]  
%    outc ..... coefficients in vector shape: cosine part            [1,k]  
%    outs ..... coefficients in vector shape: sine part              [1,k]  
%                          
%----------------------------------------------------------------------------
   

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref: 
% To  save energy and keep line with our own project， we directly use some
% function from project 'SHBundle'
%**************************************************************************                        
[outc,outs,nm] = cs2vec(in,ordflag);  %this function comed from project 'SHBundle'.                                 
                      
end

