function [nn,mm]=get_nnmm(maxn)
% [nn,mm]=get_nnmm(maxn)
%----------------------------------------------------------------------------
% In   : maxn   [1x1]   maximum degree
%
% Out  : nn/mm  [1xen]  column-vector 
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-20
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
nn=zeros(get_en(maxn),1);
mm=zeros(get_en(maxn),1);
k=0;
for n=0:maxn
    for m=0:n
    k=k+1;
        nn(k)=n;
        mm(k)=m;
    end
end
end

