function [r,p]=ts_corrcoef(solts1,solts2)
%   solts1 holds the leading time
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-02-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

tt1=solts1.time;
tt2=solts2.time;
tws1=solts1.value;
tws2=solts2.value;
tws2=interp1(tt2,tws2,tt1);
[r,p]=corrcoef(tws1(:),tws2(:));
r=r(1,2);
p=p(1,2);
end

