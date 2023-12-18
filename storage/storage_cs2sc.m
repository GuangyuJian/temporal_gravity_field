function [sc, rows, cols]=storage_cs2sc(field, backval)                               
%                              
% CS2SC(FIELD,backval) converts the square (L+1)x(L+1) matrix FIELD, containing
% spherical harmonics coefficients in |C\S| storage format into a 
% rectangular (L+1)x(2L+1) matrix in  /S|C\format.
%
% IN:
%    field .... the square (L+1)x(L+1) matrix FIELD , containing
%               spherical harmonics coefficients in |C\S| storage format
%    backval .. optional input and describes the matrix entries, 
%               where m > l. Default is 0!
% OUT: 
%    sc ....... rectangular (L+1)x(2L+1) matrix in  /S|C\format
%    rows ..... rows of rectangular (L+1)x(2L+1) matrix  in  /S|C\format
%    cols ..... columns of rectangular (L+1)x(2L+1) matrix  in  /S|C\format                       
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
[sc, rows, cols] = cs2sc(field, backval);  %this function comed from project 'SHBundle'.                                 
                                  
                              
end

