clear;
load('csrshcdo60_2.mat')
mshc_sm=sol_shc_mvmds;
load('jplshcdo60_2.mat');
mshc_sm=mshc_sm+sol_shc_mvmds;
load('gfzshcdo60_2.mat');
mshc_sm=mshc_sm+sol_shc_mvmds;

mshc_sm=mshc_sm/3;
%%
load('csrshcdo60_2.mat')
mshc_sm=sol_shc_vmds
mshc_sm=sol_shc_ssas
% mshc_sm=sol_shc_ms
mshc_sm=sol_shc_sv;
disp('3sdc');
%%
load('E:\code\20240127\test\graduate_paper\sec2\study_basin_data\my_basin4graduate.mat')
myf=sol_filter(60);
myb=mybasin(6);
for fir=-82:-78
myb.set_single(fir,9);
mysf=mshc_sm.shc2sf(myf,myb,'mc');
hold on;
mysf.show_single
end
%%
delta=20;
r=300;
myf=sol_filter(60);
myf.pre_destrip(0,4,6);
% myf.pre_destrip_ddk(5);
myf.set_filter('rec',1,'gauss',r);
load('E:\V4_已完成论文代码\vmd用于Panama区域TWS变化\数据准备\边界和掩膜生成\panama_mask025csr.mat')

load('E:\code\20240127\test\graduate_paper\sec2\study_basin_data\my_basin4graduate.mat')

myb=study_basin(0.25);
myb=mybasin(6);
myb.mask=panama_mask025_csr;

mysf=mshc_sm.shc2sf(myf,myb,'mc');
mysf.show_range=[-100 -70 0 30];
%%

my_addpath('E:\code\20240127\test\temporal_gravity_field\mask_mat');
load('csr_mask.mat')
 [sf_fm]=fm_zf(mysf,myf,myb,ocean_mask_csr,delta);
%%
%%
 myb=mybasin(6);
 
sf_fm.set_time(mysf.time,mysf.int_year,mysf.int_month);
 
 mysf=extra(mysf,1:196);
sf_fm=extra(sf_fm,1:196);
 

 ts=sf2ts(mysf,myb);
 tsfm=sf2ts(sf_fm,myb);
 %%
 ts2=ts.filling([2002,4,2021,4]);
tsfm2=tsfm.filling([2002,4,2021,4]);


tslsw=lsw.sf2ts(myb);

tsgws=tsfm2-tslsw;
%%
ts2.ts_plot
hold on;

tsfm2.ts_plot
 %%
ts.ts_plot
hold on;

tsfm.ts_plot
%%

close all
nexttile;
yyaxis left;

tsgws.ts_plot;

yyaxis right;
plot(gw2(:,1),gw2(:,2));
xlim([2014 2015.3]);
nexttile;
yyaxis left;
tsgws.ts_plot;
yyaxis right;
plot(gw1(:,1),gw1(:,2));
xlim([2008 2009])
%%


x32=interp1(tsgws.time,tsgws.value,gw2(:,1));
x31=interp1(tsgws.time,tsgws.value,gw1(:,1));

corrcoef(x32,gw2(:,2))
corrcoef(x31,gw1(:,2))