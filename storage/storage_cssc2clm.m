function  clm = storage_cssc2clm(mat)
%
% CSSC2CLM converts CS, SC format matrices and degree variance information
% to Colombo ordering vectors [l m Clm Slm]
%
% IN:
%    mat ..... CS, SC or degree vector
%    lmax .... Maximum degree of the Spherical Harmonic development
%
% OUT:
%    vec ..... [l m Clm Slm] vector with Colombo ordering
%
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
% SHBundle_check('cssc2clm')
% vec = cssc2clm(mat,lmax);  %this function comed from project 'SHBundle'.
[rows,cols]=size(mat);

if rows==cols
    [vecc,vecs,nm]=storage_cs2vec(mat);
elseif rows*2-1==cols
    [cs]=storage_sc2cs(mat);
    [vecc,vecs,nm]=storage_cs2vec(cs);
else
    error('!');
end
clm=[nm vecc vecs];

end

