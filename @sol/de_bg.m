function [self]=de_bg(self,ts,te)
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
% date: 2024-01-13
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
if nargin==1
    ts=2004;
    te=2010;
end
bg=mean(self,ts,te);
objn=self-bg;

switch class(self)
    case {'sol_sf','sol_ts'}
        self.value=objn.value;
    case 'sol_shc'
        self.storage=objn.storage;
end

clear objn bg;
disp('de_bg: background is removed');
message=sprintf('------------------\n baseline:');
self.append_info(message);
message=sprintf('start: %f end: %f',ts,te);
self.append_info(message);

end

