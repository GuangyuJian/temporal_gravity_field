function [shc,time,int_year,int_month,shc_sigma]=gdut_read_leo_gsm_dir(dir_in,nmax)
%  [shc,time,int_year,int_month,shc_sigma]=gdut_read_gsm_dir(dir_in,nmax)
% this function dedicated to read all the leo-gsm file in a the same path
%----------------------------------------------------------------------------
% In   :
%		dir_in	[char]	full-path of all the gsm file
%
% Out  :
%		nmax	[1x1]	maximum degree
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-11
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************



if dir_in(end)~='\'
    dir_in=[dir_in '\' ];
else

end

% Step2:To obtain a list of GRACE filename in the Dir_GRACE
all_file=dir(fullfile(dir_in,'Tongji-LEO*gfc'));%获取文件名


num_t=length(all_file);%计算文件数
if num_t==0
    show_time_tag;
    error("gdut_read_leo_gsm_dir:    路径未找到文件");
else
    show_time_tag;
    disp("gdut_read_leo_gsm_dir:    共检索到"+num_t+"个文件");
end
%Step3:Accroding to the num of file(num_t)，loding DATA

for t=1:num_t
    
    file_name=all_file(t).name;
    fid=fopen([dir_in file_name]);
    if fid == -1
        Disp_Clock;
        disp(Dir_GRACE);
        disp(all_file(t).name);
        error("gdut_read_gsm_dir:   Error opening the file 无法打开文件,请检查路径格式");
    end
    %读入数据Loading


    [shc(t).cnm,shc(t).snm,shc_sigma(t).cnm_sigma,shc_sigma(t).snm_sigma,time(t),int_year(t),int_month(t)]=gdut_read_leo_gsm(dir_in,file_name,nmax);

end

show_time_tag();
disp("gdut_read_gsm_dir:    reading  is over");
pause(0.2);


end

