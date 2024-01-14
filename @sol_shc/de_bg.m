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
bg=mean(self,2004,2010);

objn=self-bg;
self.storage=objn.storage;
clear objn bg;
% for ntt=1:length(self.time)
% 
%     self.storage(ntt).cnm=self.storage(ntt).cnm-bg.storage.cnm;
%     self.storage(ntt).snm=self.storage(ntt).snm-bg.storage.snm;
% end
disp('de_bg: background is removed');
message=sprintf('------------------\n baseline:');
self.append_info(message);
message=sprintf('start: %f end: %f',ts,te);
self.append_info(message);

end

