function [h]=wnm_plot(self)
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
% date: 2023-12-24
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

wnm=self.wnm;
maxn=self.maxn;


h=plot(wnm,'LineWidth',1.5);
ylabel('weight');
caxis ([0 1])
grid on;

set(gca,'FontSize',12)
end

