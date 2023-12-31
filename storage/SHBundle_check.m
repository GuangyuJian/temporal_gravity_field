function []=SHBundle_check(func_name)
% Check the function whether in path 
% and provdie the source project of the function
%----------------------------------------------------------------------------
% In   :
%           func_name       char
% Out  :
%           none
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-22
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

if exist(func_name)


else
    error(['function ' func_name ' from SHBundle project in the current path ']);
end

end

