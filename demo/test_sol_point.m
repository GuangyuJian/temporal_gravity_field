load time_info.mat;
load('E:\code\20240127\test\graduate_paper\sec2\grace_data_prepare\dahiti_lake\ts_lake.mat', 'tsni')
load('E:\code\20240127\test\temporal_gravity_field\grace_sol_get\mascon\sfcsr.mat')
load('sf_fm_self_noise11.mat')
%%
sf_fm.set_time(time,int_year,int_month);
%%
[tscsr]=get_point_ts(sfcsr,-85.5,11.5);
[ts]=get_point_ts(sf_fm,-85.5,11.5);
%%
figure;
yyaxis left;
h(1)=tscsr.ts_plot;

h(1).Color='blue';
h(1).LineStyle='-';
hold on;
h(2)=ts.ts_plot;
h(2).Color='green';
h(2).LineStyle='-';

yyaxis right;

tsni.ts_plot
%%
trange=[2002,4,2022,3];
fs=12;
figure;
yyaxis left;
h(1)=tscsr.tsa_fft(fs,trange);
h(1).Color='blue';
h(1).LineStyle='-';
hold on;
h(2)=ts.tsa_fft(fs,trange);
h(2).Color='green';
h(2).LineStyle='-';

yyaxis right;
tsni.tsa_fft(fs,trange);
%%
clc;
twstemp=interp1(tsni.time,tsni.value,tscsr.time);

corrcoef(twstemp,tscsr.value)
corrcoef(twstemp,ts.value)
