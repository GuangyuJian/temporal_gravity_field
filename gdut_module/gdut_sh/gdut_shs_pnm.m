function [ta,tb]=gdut_shs_pnm(cnm,snm,pnm,maxn)                               
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
% date: 2024-01-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
                              
 

for mm=0:maxn
    nn=mm:maxn;
    lc=2+(nn+2).*(nn-1)/2+mm;

    cc=cnm(lc);
    ss=snm(lc);

    ta(:,mm+1)=pnm(lc,:)'*cc(:);
    tb(:,mm+1)=pnm(lc,:)'*ss(:);
end
% hold on;
% plot(ta(30,:))
% sfvalue=ta*cmf+tb*smf;                             
                              
                              
end

