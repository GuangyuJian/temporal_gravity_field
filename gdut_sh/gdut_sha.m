function [cnm,snm]=gdut_sha(sf_value,cmf,smf,pnm,maxn,ds)
% [cnm,snm]=gdut_sha(sf_value,cmf,smf,pnm,maxn,ds)
%----------------------------------------------------------------------------
% In   :    sfvalue     [rr x   cc] spherical function 
%           cmf/smf     [maxn+1 x   cc] cos or sin basis
%           pnm         [rr x   en] 
%           maxn        [1  x   1]  maximum degree
%           ds          [1 x   rr] differential element 
% Out  :
%           rr/cc is the total number of element in row/column.
%           cnm/snm     [1xen]  vecc/vecs in degree-dependent
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-24
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 
%**************************************************************************
%Ref:
%**************************************************************************

coe=1/(4*pi);
temp=coe*pnm.*ds * sf_value;

for nn=0:maxn
    mm=0:nn;
    [loc]=get_nm(nn,mm);

    tempc=temp(loc,:).*cmf(1:nn+1,:);
    temps=temp(loc,:).*smf(1:nn+1,:);

    cnm(loc,1)=sum(tempc,2);
    snm(loc,1)=sum(temps,2);
end


end

