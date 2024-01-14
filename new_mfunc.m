function new_mfunc(filename)
% 生成 MATLAB 头注释模板
%   generate a  filename.m file in current path-
%**************************************************************************
% In   :
%       filenemae   [char]
% Out  :
%       none
%----------------------------------------------------------------------------
% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-18
% Encode: UTF-8
%**************************************************************************
%
dateStr = datestr(now, 'yyyy-mm-dd');

exi_fid=exist([filename '.m']);
if exi_fid==0
    disp('it is ok!');
elseif exi_fid==2
    error('m.file exist；please rename');
end

fid = fopen([filename '.m'],'w');
if fid<0
    error(['cannot open' filename '.m ']);
end

% 创建头注释

header = sprintf(['function []=' filename  '()' ' %s\n\n']);
header = [header, sprintf('                              \n')];
header = [header, sprintf('%%                              \n')];
header = [header, sprintf('%%----------------------------------------------------------------------------\n')];
header = [header, sprintf('%% In   : %s\n', "   ")];
header = [header, sprintf('%%                              \n')];
header = [header, sprintf('%% Out  : %s\n', "   ")];
header = [header, sprintf('%%                              \n')];
header = [header, sprintf('%%----------------------------------------------------------------------------\n')];
header = [header, sprintf('                              \n')];
header = [header, sprintf('                              \n')];
header = [header, sprintf('%% Authors: %s\n', "Karl Jian (K.J)")];
header = [header, sprintf('%% address: %s\n', "Guangdong University of Technology(GDUT)")];
header = [header, sprintf('%% email: %s\n', "gyjian@mail2.gdut.edu.cn")];
header = [header, sprintf('%% date: %s\n', dateStr)];
header = [header, sprintf('%% MATLAB_version: %s\n', version)];
header = [header, sprintf('%% Encode: UTF-8  \n')];
header = [header, sprintf('%%**************************************************************************\n')];
header = [header, sprintf('%%Ref:\n')];
header = [header, sprintf('%%**************************************************************************\n')];
header = [header, sprintf('                              \n')];
header = [header, sprintf('                              \n')];
header = [header, sprintf('                              \n')];
header = [header, sprintf('                              \n')];
header = [header, sprintf('end\n')];


fprintf(fid, '%s\n', header);
fclose(fid);
edit([filename '.m'])
disp('m_file is generated');
end
