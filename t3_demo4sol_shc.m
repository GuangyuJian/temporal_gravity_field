clear;
clc;

%% 读取CSR系数
%  并创建sol_shc对象
dir_in='test_alpha\csrdo60_unfilter';
[shc,time,int_year,int_month]=gdut_read_gsm_dir(dir_in,60);
% clc;
csr_shc=sol_shc(shc,60,'shc','gc');
csr_shc.time=time;
csr_shc.int_year=int_year;
csr_shc.int_month=int_month;

% 替换和改正项
dir_in='TN-14_C30_C20_GSFC_SLR.txt';
replace_c20c30(csr_shc,dir_in); 

dir_in='TN-13_GEOC_CSR_RL0602.txt';
replace_degree1(csr_shc,dir_in);

dir_in="GIA_mass0km.txt";
 replace_gia( csr_shc,dir_in,2004,2010);
%  去除背景场2004-2010 也提供了如下背景场去除方法
 csr_shc.de_bg(2004,2010);
% 读取静态背景场 ——————  去除背景场
%  并创建sol_shc对象
% [bg]=bg_ggm05c();
% csr_shc=csr_shc-bg;
% clc;
%% 记录了csr_shc的处理过程
clc;
csr_shc.show_info;
%%
show_time_tag;
% dialog;
pre_fix='alpha_';
filename=[pre_fix 'my_shc'];
save([filename],"csr_shc");



