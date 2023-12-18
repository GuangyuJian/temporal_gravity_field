function varargout=storage_clm2sc(clm, varargin)                               
%                              
% CLM2SC converts a list of coefficients in clm-format to /S|C\-format 
% and--if available--does the same with the standard deviations.
%
% IN:
%    clm ............ coefficients as matrix in the form [l m C S [sigma_C, sigma_S]]
%    'max_lm' ....... only coefficients up to a degree = order = max_lm are
%                     used. (default: read all coefficients (max_lm = inf)) 
%    'gcoef2sc' ..... provides functionality of deprecated function gcoef2sc, 
%                     see "OUT (gcoef2sc)" below. (default: false)
%
% OUT (standard):
%    sc ............. coefficients in /S|C\ format
%    maxGOout ....... maximum degree and order available
%    stdsc .......... standard deviations of the coefficients in /S|C\ (if
%                     available)
%
% OUT (gcoef2sc):
%    sc ............. coefficients in /S|C\ format
%    c .............. only C coefficients in lower triangular matrix
%    s .............. only S coefficients in lower triangular matrix
%
% EXAMPLE:
%    clm2sc(clm, 'max_lm', 30, 'gcoef2sc', false);
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
varargout = clm2sc(clm, varargin);  %this function comed from project 'SHBundle'.                                 
                                  
                              
end

