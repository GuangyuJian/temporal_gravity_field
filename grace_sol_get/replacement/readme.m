% all download in
% https://www2.csr.utexas.edu/grace/RL0602_mascons.html

% test1
dir_in='TN-14_C30_C20_GSFC_SLR.txt';
% nmax=60;
[time,rc20, rc20_sgima,rc30,rc30_sigma]=gdut_read_c20c30(dir_in);
%% test2
dir_in='E:\Dsektop\gsm4grace\csr60un\';
[shc,time,int_year,int_month]=gdut_read_gsm_dir(dir_in,60);
clc;
csr_shc=sol_shc(shc,60,'shc','gc');
csr_shc.time=time;
csr_shc.int_year=int_year;
csr_shc.int_month=int_month;

dir_in='TN-14_C30_C20_GSFC_SLR.txt';
temp1=[csr_shc.storage(1).cnm(4) csr_shc.storage(1).cnm(7)];
record=replace_c20c30(csr_shc,dir_in);
temp2=[csr_shc.storage(1).cnm(4) csr_shc.storage(1).cnm(7)];
temp1-temp2
%% test3

dir_in='TN-13_GEOC_CSR_RL0602.txt';
% nmax=60;
[output0,output1, times,  timee ]=gdut_read_degree1(dir_in);
%% test4
dir_in='E:\Dsektop\gsm4grace\csr60un\';
[shc,time,int_year,int_month]=gdut_read_gsm_dir(dir_in,60);
clc;
csr_shc=sol_shc(shc,60,'shc','gc');
csr_shc.time=time;
csr_shc.int_year=int_year;
csr_shc.int_month=int_month;
%%
dir_in='TN-13_GEOC_CSR_RL0602.txt';
temp1=[csr_shc.storage(1).cnm(2) csr_shc.storage(1).snm(2)];
record=replace_degree1(csr_shc,dir_in);
temp2=[csr_shc.storage(1).cnm(2) csr_shc.storage(1).snm(2)];
temp1-temp2
%% test5

dir_in="GIA_mass0km.txt";
 replace_gia( csr_shc,dir_in,2004,2010);
 %%
 clc;
 csr_shc.show_info
%%
csr_shc=csr_shc-csr_shc_gia;