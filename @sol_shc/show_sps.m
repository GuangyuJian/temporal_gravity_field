function [h,sc_degre]=show_sps(self,tt)                               
% h=show_shc_degree(self,tt)
% h=self.show_shc_degree(tt)
% show the signal degree amplitude (total power per degree) of shc for a given time index (tt)  
%----------------------------------------------------------------------------
% In   : self   [1x1]  @sol_shc    
%        tt     [1x1]   time index
% Out  : h      [1x1]   @handle of plot
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-23
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
sc_degre=sqrt(sum(sc.^2,2)./nlist(:));
h=semilogy(2:1:maxn,sc_degre(3:end));
grid on;           
xticks([0:10:maxn]);
xticklabels({0:10:maxn});

[ym_char,ym_flag]=check_ym(self,tt);
if ym_flag==1
    title(ym_char);
end
set(gca,'FontSize',10,'FontUnits','points')

end

