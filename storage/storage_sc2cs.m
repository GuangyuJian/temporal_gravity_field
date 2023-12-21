function [cs, rows, cols]=storage_sc2cs(field)                               
%                              
% SC2CS(FIELD) converts the rectangular (L+1)x(2L+1) matrix FIELD, containing
% spherical harmonics coefficients in /S|C\ storage format into a 
% square (L+1)x(L+1) matrix in |C\S| format.
%
% IN:
%    field .... the rectangular (L+1)x(2L+1) matrix FIELD, containing
%               spherical harmonics coefficients in /S|C\ storage format
%
% OUT: 
%    cs ....... square (L+1)x(L+1) matrix in |C\S| format
%    rows ..... the number of rows for matrix FIELD
%    cols ..... the number of columns for matrix FIELD                      
%----------------------------------------------------------------------------
   

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref: 
% To  save energy and keep line with our own project， we directly use some
% function from project 'SHBundle'
%**************************************************************************                        

SHBundle_check('sc2cs')
[cs, rows, cols] = sc2cs(field);  %this function comed from project 'SHBundle'.                                 
                                  
                              
end

