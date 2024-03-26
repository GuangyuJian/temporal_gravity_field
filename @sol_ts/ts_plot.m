function [h]=ts_plot(self)
% plot the time series from @sol_ts (1x1 or 1xn)
%----------------------------------------------------------------------------
% In   :    self [1x1] or [1xn] @sol_ts    
%
% Out  :    h    [1x1] or [1xn]  handle of plot
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-29
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
% modify in 20240316
% it can plot the ts from a vector of @sol_ts
%**************************************************************************
%Ref:
%**************************************************************************
for k=1:length(self)
    tempts=self(k);
    h(k)=plot(tempts.time,tempts.value,'LineWidth',1.5);
    ylabel(tempts.unit);
    xlabel('Year');
    title(tempts.name);
%     set(gca,'FontSize',12,'FontWeight','Bold');
    set(gca,'FontSize',10,'FontUnits','points')
    grid on;
    box on;
    hold on;
end
end

