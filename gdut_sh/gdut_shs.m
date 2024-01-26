function [sfvalue]=gdut_shs(cnm,snm,cmf,smf,pnm,maxn)
%  [sfvalue]=gdut_shs(cnm,snm,cmf,smf,pnm,maxn)
%----------------------------------------------------------------------------
% In   :    cnm/snm     [1xen]  vecc/vecs in degree-dependent
%           cmf/smf     [maxn+1 x   cc] cos or sin basis
%           pnm         [rr x   en] 
%           maxn        [1  x   1]  maximum degree
% Out  :    sfvalue     [rr x   cc] spherical function
%           rr/cc is the total number of element in row/column.
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-11
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 
%**************************************************************************
%Ref:
%**************************************************************************

%  Sum of series in order-dependent
for mm=0:maxn
    nn=mm:1:maxn;
%     lc=2+(nn+2).*(nn-1)/2+mm;
    lc=get_nm(nn,mm);
    cc=cnm(lc);
    ss=snm(lc);

    ta(:,mm+1)=pnm(lc,:)'*cc(:);
    tb(:,mm+1)=pnm(lc,:)'*ss(:);
end

sfvalue=ta*cmf+tb*smf;
end

