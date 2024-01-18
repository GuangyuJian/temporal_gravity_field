%demo of relative path;
clear;
clc;
file_name='GSM-2_2018152-2018181_GRFO_UTCSR_BA01_0600.gfc';
dir_in=[''];
nmax=60;
 [C,S,C_Sigma,S_Sigma]=gdut_read_gsm(dir_in,file_name,nmax);
 %%
 %demo of full path;
dir_in='E:\github_desktop\test\temporal_gravity_field\Read_func\test_demo\';
file_name='GSM-2_2018152-2018181_GRFO_UTCSR_BA01_0600.gfc';

nmax=60;
 [C,S,C_Sigma,S_Sigma]=gdut_read_gsm(dir_in,file_name,nmax);
 %%
  %%
 %demo of full path;
 clear;
 clc;
file_name='kfilter_DDK3_GSM-2_2018295-2018313_GRFO_UTCSR_BA01_0600.gfc';
dir_in=[''];
nmax=60;
 [C,S,C_Sigma,S_Sigma,time,int_year,int_month]=gdut_read_gsm(dir_in,file_name,nmax);

%% 
dir_in='E:\Dsektop\UNFILTER';
[shc,time,int_year,int_month]=gdut_read_gsm_dir(dir_in,60);
%%
csr_shc=sol_shc(shc,60,'shc','gc');
csr_shc.time=time;
csr_shc.int_year=int_year;
csr_shc.int_month=int_month;

%%

%%
SHS();



























