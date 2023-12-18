function [out]=storage_vec2cs(nm,inC,inS)                               
%                              
%----------------------------------------------------------------------------
% VEC2CS rearranges a vector shaped set of spherical harmonic
% coefficients into cs-format. The vector order is given by the ordering
% vector.

% 
% IN:
%    nm ...... ordering vector                                      [2,k]  
%              maximum degree - degree-wise ordering is assumed     [1,1]  
%    inC ..... coefficients in vector shape: cosine part            [1,k]  
%    inS ..... coefficients in vector shape: sine part              [1,k]  
% 
% OUTPUT: 
%    out ..... output in cs- or sc- format                            
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
out = vec2cs(nm,inC,inS);  %this function comed from project 'SHBundle'.                                 
                      
end

