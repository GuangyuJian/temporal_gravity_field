function [h,sc_degre ]=show_sps_perm(self,tt)                               
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
% date: 2024-03-28
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
                              
                     
maxn=self.maxn;
tempc=self.storage(tt).cnm;
temps=self.storage(tt).snm;
[nn,mm]=get_nnmm(maxn); %modify by kj 20240419
clm=[nn mm tempc temps];


[sc]=storage_clm2sc(clm, maxn);

% nlist=(0:1:maxn)*2+1;
% nlist=(0:1:maxn)*2+1;
nlist=1;
% sc_degre=sqrt(sum(sc.^2,2))./nlist(:);

temp=sum(sc.^2,1);
temp1=fliplr(temp(1:61));
temp2=[0 (temp(62:end))];
temp1=temp1+temp2;
sc_degre=sqrt(temp1./nlist(:));
h=semilogy(2:1:maxn,sc_degre(3:end));
grid on;           
xticks([0:10:maxn]);

xticklabels({0:10:maxn});

if ~isempty(self.time)
iy=self.int_year(tt);
im=self.int_month(tt);

if im<10
titlestr=([num2str(iy) '-0' num2str(im) ]);
else
titlestr=([num2str(iy) '-' num2str(im) ]);
end
title(titlestr);
end
set(gca,'FontSize',10,'FontUnits','points')
                              
                              
                              
end

