function [h]=imagesc_tt(self,tt)
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
% date: 2023-12-29
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 
%**************************************************************************
%Ref:
%**************************************************************************

fir=self.fir;
ceta=self.ceta;

h=imagesc(fir,ceta,self.value(:,:,tt));
axis xy;

c=colorbar('eastoutside');
c.Label.String=self.unit;

colormap("jet");

end

