clear;
dir_in='E:\Dsektop\gsm4grace\csr60un\';
[shc,time,int_year,int_month]=gdut_read_gsm_dir(dir_in,60);
clc;
csr_shc=sol_shc(shc,60,'shc','gc');
csr_shc.time=time;
csr_shc.int_year=int_year;
csr_shc.int_month=int_month;
%%
dir_in='TN-14_C30_C20_GSFC_SLR.txt';
replace_c20c30(csr_shc,dir_in); 
%%
dir_in='TN-13_GEOC_CSR_RL0602.txt';
record=replace_degree1(csr_shc,dir_in);
%% 
csr_shc.de_bg(2004,2010);
%%
dir_in="GIA_mass0km.txt";
 replace_gia( csr_shc,dir_in,2004,2010);
 %%
 clc;
 csr_shc.show_info