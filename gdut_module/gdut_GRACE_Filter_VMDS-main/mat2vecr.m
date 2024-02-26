function [vecr]=mat2vecr(mat)
% This function arranges the matrix by row index
% mat =[1 2 3;2 3 4];
% vec_r= [1 2 3 2 3 4]';
% 
vecr=mat';
vecr=vecr(:);
end