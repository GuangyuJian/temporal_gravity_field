function [h,sc_degre2,time,kk2]=show_spst(self)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-29
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

maxn=self.maxn;
ntime=length(self.time);
trange=[self.int_year(1),self.int_month(1),self.int_year(end),self.int_month(end)];
[time,int_year,int_month]=gdut_uniform_time(trange)  ;

for tt=1:ntime
[sc_degre(:,tt)]=self.sps_pern(tt);
end
sc_degre2=nan(maxn+1,length(time));
for tt=1:ntime
    kk1=find(int_year==self.int_year(tt)&self.int_month(tt)==int_month);
    sc_degre2(:,kk1)=(sc_degre(:,tt));
    kk2(tt)=kk1;
end

clc;
h=imagesc(time,0:maxn,sc_degre2);
set(h,'alphadata',~isnan(sc_degre2));
colormap(gca,flipud(hot));
caxis([0 2].*10^-12);
% colorbar();
sc_degre2(isnan(sc_degre2))=0;
end

