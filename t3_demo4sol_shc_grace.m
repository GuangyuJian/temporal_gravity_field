clear;
clc;

%% 读取CSR系数
%  并创建sol_shc对象
dir_in='test_alpha\csrdo60_unfilter';
[shc,time,int_year,int_month,shc_sigma]=gdut_read_gsm_dir(dir_in,60);
% clc;
csr_shc=sol_shc(shc,60,'shc','gc');
csr_shc.time=time;
csr_shc.int_year=int_year;
csr_shc.int_month=int_month;
csr_shc.shc_sigma=shc_sigma;
% 替换和改正项
dir_in='TN-14_C30_C20_GSFC_SLR.txt';
replace_c20c30(csr_shc,dir_in); 

dir_in='TN-13_GEOC_CSR_RL0602.txt';
replace_degree1(csr_shc,dir_in);

dir_in="GIA_mass0km.txt";
 replace_gia( csr_shc,dir_in,2004,2010);
%% 展示加减、平均操作
% 读取静态背景场 ——————  去除背景场
% 
%  并创建sol_shc对象
[bg]=bg_ggm05c();
csr_shc=csr_shc-bg;
%  去除背景场2004-2010 也提供了如下背景场去除方法
 csr_shc.de_bg(2004,2010);
clc;

%% 记录了csr_shc的处理过程
clc;
csr_shc.show_info;

%% 展示条带模式
figure('Position',[0 0 1500 900]);
tiledlayout(2,3,"TileSpacing","compact");
nexttile;
csr_shc.show_nss(1,6,'c');
% 展示球谐系数
nexttile;
csr_shc.show_shc(1);
% 展示球谐系数标准差
nexttile;
csr_shc.show_shc_sigma(1);
% 展示球谐系数的信号阶方差
nexttile;
csr_shc.show_shc_degree(1);
% 展示球谐系数的噪声阶方差
nexttile;
csr_shc.show_shc_degree_sigma(1);
%%
csr_shc.change_type('mc'); %对比图内容的变化。
figure('Position',[0 0 1500 900]);
tiledlayout(2,3,"TileSpacing","compact");
nexttile;
csr_shc.show_nss(1,6,'c');
% 展示球谐系数
nexttile;
csr_shc.show_shc(1);
% 展示球谐系数标准差
nexttile;
csr_shc.show_shc_sigma(1);
% 展示球谐系数的信号阶方差
nexttile;
csr_shc.show_shc_degree(1);
% 展示球谐系数的噪声阶方差
nexttile;
csr_shc.show_shc_degree_sigma(1);

%%
show_time_tag;
% dialog;
pre_fix='alpha_csr_';
filename=[pre_fix 'my_shc'];
save([filename],"csr_shc");
%%
