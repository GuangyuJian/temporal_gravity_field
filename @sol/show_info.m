function []=show_info(self)
% show the info of object
%----------------------------------------------------------------------------
% In   : self@sol [1x1]
%
% Out  : none
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
if length(self)==1
fprintf(self.info)
else
error('!wrong: more than one object@sol');
end



end

