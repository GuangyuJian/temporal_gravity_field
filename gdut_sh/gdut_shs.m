function [sfvalue]=gdut_shs(cnm,snm,cmf,smf,pnm,maxn)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-11
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 %**************************************************************************
%Ref:
%**************************************************************************

% nceta=size(pnm,2);
% temp=zeros(size(pnm));
% for i=1:nceta
%     temp(:,i)=cnm.*pnm(:,i);
% end
% value= ( cmf* temp)';
% for i=1:nceta
%     temp(:,i)=snm.*pnm(:,i);
% end
% value= value+(smf* temp )';

for mm=0:maxn
    nn=mm:maxn;
    lc=2+(nn+2).*(nn-1)/2+mm;

    cc=cnm(lc);
    ss=snm(lc);

    ta(:,mm+1)=pnm(lc,:)'*cc(:);
    tb(:,mm+1)=pnm(lc,:)'*ss(:);
end
sfvalue=ta*cmf+tb*smf;
end

