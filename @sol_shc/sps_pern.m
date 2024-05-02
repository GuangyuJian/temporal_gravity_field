function [sc_degre]=sps_pern(self,tt)                               
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
tempc=self.storage(tt).cnm;
temps=self.storage(tt).snm;
[nn,mm]=get_nnmm(maxn); %modify by kj 20240419
clm=[nn mm tempc temps];

[sc]=storage_clm2sc(clm, maxn);

% nlist=(0:1:maxn)*2+1;
nlist=(0:1:maxn)*2+1;
% nlist=1;
% sc_degre=sqrt(sum(sc.^2,2))./nlist(:);
sc_degre=sqrt(sum(sc.^2,2)./nlist(:));                             
                              
                              
                              
end

