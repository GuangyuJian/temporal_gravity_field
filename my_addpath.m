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
addpath(genpath([root_path]));
disp([root_path 'is done'])
end