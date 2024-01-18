function [cs]=storage_sc2cs(sc)                               
%        
% [cs, rows, cols]=storage_sc2cs(sc)     
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
[rr,cc] = size(sc);  
if (cc~=2*rr-1)
    error('!');
else
    lmax = rows-1;
    c    = sc(:,lmax+1:2*lmax+1);
    s    = [zeros(lmax+1,1) sc(:,1:lmax)];
    cs   = tril(c) + triu(rot90(s),1);    
end

end

