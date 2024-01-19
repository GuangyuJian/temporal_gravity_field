function [h]=ts_plot(self)
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

plot(self.time,self.value,'LineWidth',1.5);
ylabel(self.unit);
xlabel('Year');
title(self.name);
set(gca,'FontSize',12,'FontWeight','Bold');

grid on;
box on;
end

