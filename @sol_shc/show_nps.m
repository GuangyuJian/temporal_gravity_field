function [h,sc_degre]=show_nps(self,tt)
% h=show_shc_degree_sigma(self,tt)
% h=self.show_shc_degree_sigma(tt)
% show the noise degree amplitude of noise for a given time index (tt)
%----------------------------------------------------------------------------
% In   : self   [1x1]  @sol_shc
%        tt     [1x1]   time index
%
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
tempc=self.shc_sigma(tt).cnm_sigma;
temps=self.shc_sigma(tt).snm_sigma;
[nn,mm]=get_nnmm(maxn); %modify by kj 20240419
clm=[nn mm tempc temps];


[sc]=storage_clm2sc(clm, maxn);
% sc(sc==0)=nan;
% sc=log10((sc));
% h=imagesc(-maxn:1:maxn,0:maxn,sc);
% nlist=(0:1:maxn)*2+1;
nlist=1; % for total power spectrum
sc_degre=sqrt(sum(sc.^2,2)./nlist(:));
h=semilogy(2:1:maxn,sc_degre(3:end));

grid on;
%    set(gca,'FontSize',10,'units','points')
set(gca,'FontSize',10,'FontUnits','points')

[ym_char,ym_flag]=check_ym(self,tt);
if ym_flag==1
    title(ym_char);
end

end

