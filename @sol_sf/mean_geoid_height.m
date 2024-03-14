function [sigma_n]=mean_geoid_height(self,maxn)
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
% date: 2024-01-26
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

[rows,columns,ntime]=size(self.value);
res=180/rows;

myf=sol_filter(maxn);
myb=study_basin(res);

shc=self.sf2shc(myf,myb,'gc');
shc.change_type('gc');
value=shc.storage;

radius=myf.radius_earth; %km
for tt=1:ntime
    cnm=value(tt).cnm;
    snm=value(tt).cnm;
    for nn=0:maxn
%         nlist=2*nn+1;
        nlist=1;
        loc=get_nm(nn,0:nn);
        tempsum=cnm(loc).^2+cnm(loc).^2;
        temp(nn+1,tt)=radius*sqrt(sum(tempsum,'all')/(nlist));
    end
end
sigma_n=mean(temp,2)*1000;
end

