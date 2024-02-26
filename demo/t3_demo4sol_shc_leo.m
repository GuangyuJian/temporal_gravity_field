clear;
clc;

%% 读取CSR系数
%  并创建sol_shc对象
dir_in='test_alpha\leo';
[shc,time,int_year,int_month,shc_sigma]=gdut_read_leo_gsm_dir(dir_in,60);
% clc;
leo_shc=sol_shc(shc,60,'shc','gc');
leo_shc.time=time;
leo_shc.int_year=int_year;
leo_shc.int_month=int_month;
leo_shc.shc_sigma=shc_sigma;
% 替换和改正项

dir_in="GIA_mass0km.txt";
 replace_gia( leo_shc,dir_in,2004,2010);
%% 展示加减、平均操作
% 读取静态背景场 ——————  去除背景场
% 
%  并创建sol_shc对象
[bg]=bg_ggm05c();
leo_shc=leo_shc-bg;
%  去除背景场2004-2010 也提供了如下背景场去除方法
 leo_shc.de_bg(2004,2010);
clc;

%% 记录了leo_shc的处理过程
clc;
leo_shc.show_info;
%%
show_time_tag;
% dialog;
pre_fix='alpha_leo';
filename=[pre_fix 'my_shc'];
save([filename],"leo_shc");
%%
