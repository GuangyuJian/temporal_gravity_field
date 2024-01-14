function [cnm,snm]=gdut_sha(sf_value,cmf,smf,pnm,maxn,ds)
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


% N=size(sf_value,1);

% ds1=sind(90-ceta)*(d^2);

for nn=0:maxn
    st=2+(nn+2)*(nn-1)/2;

    coe=1/(4*pi);
% %     temp=coe*pnm(st:st+nn,:).*ds * sf_value;
    tempc=coe*pnm(st:st+nn,:).*ds * sf_value.*cmf(1:nn+1,:);%求等效水高高球谐系数
    temps=coe*pnm(st:st+nn,:).*ds * sf_value.*smf(1:nn+1,:);

    cnm(st:st+nn,1)=sum(tempc,2);
    snm(st:st+nn,1)=sum(temps,2);
end


end

