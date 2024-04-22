function [self]=pre_destrip_ddk(self,option)
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
% date: 2024-01-20
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

if length(option)~=1
    error('!');
end

switch   option
    case {1,2,3,4,5,6,7,8}
        self.ddk_type=option;
    otherwise
        error('! wrong ddk');
end
self.destrip_flag=3;

end

