function []=my_addpath(root_path)
%   adding a  all sub-path in the roor_path(input)
%**************************************************************************
% In   :
%       root_path   [char]
% Out  :
%       none
%----------------------------------------------------------------------------
% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-18
% Encode: UTF-8
%**************************************************************************
% use: my_addpath('F:\V4')
% root_path='F:\V4\allmy_trans_func'
show_time_tag;
addpath(genpath([root_path]));
disp([root_path 'is done'])
end

function []=show_time_tag()
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
% date: 2024-01-11
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

if nargin==0
disp('-------------------------');
disp(datetime('now'));
end

end

