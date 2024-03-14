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
for k=1:length(self)
    tempts=self(k);
    h=plot(tempts.time,tempts.value,'LineWidth',1.5);
    ylabel(tempts.unit);
    xlabel('Year');
    title(tempts.name);
    set(gca,'FontSize',12,'FontWeight','Bold');

    grid on;
    box on;
    hold on;
end
end

