function [h]=ts_bar(self)
% show the time series from @sol_ts (1x1 or 1xn) in bar
%----------------------------------------------------------------------------
% In   :    self [1x1] or [1xn] @sol_ts
%
% Out  :    h    [1x1] or [1xn] handle of bar
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
    x=self(k).time;
    y=self(k).value;
    h(k)=bar(x,y);
end

end

