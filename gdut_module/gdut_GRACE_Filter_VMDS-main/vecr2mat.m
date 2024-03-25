function [mat]=vecr2mat(vecr,r,c)
% This function arranges the matrix by row index
% mat =[1 2 3;2 3 4];
% vec_r= [1 2 3 2 3 4]';
% 
if length(vecr)~=r*c

    error('wrong shape');    
end

mat=reshape(vecr(:),c,r);
mat=mat';

end