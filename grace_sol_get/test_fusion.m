clear
myf=sol_filter(60);
myb=study_basin(0.25);
% myf.set_filter('gauss',300);
myf.pre_destrip_ddk(6);

load('jplshcdo60_2.mat')
k=1;
mysf(k)=shc2sf(sol_shc_ms,myf,myb,'mc');
load('gfzshcdo60_2.mat')
k=1+k;
mysf(k)=shc2sf(sol_shc_ms,myf,myb,'mc');
load('csrshcdo60_2.mat')
k=1+k;
mysf(k)=shc2sf(sol_shc_ms,myf,myb,'mc');
load('shc_fusion.mat')
k=1+k;
mysf(k)=shc2sf(shc_fusion,myf,myb,'mc');

load('E:\code\20240127\test\graduate_paper\sec2\study_basin_data\my_basin4graduate.mat')
%%
for k=1:4
    k
    myts(k)=mysf(k).sf2ts(mybasin(6));
end
%%
sfdif=myts(4)-myts(3);
%%
sfdif.ts_plot
%%
for k=1:4
    hold on;
% nexttile
myts(k).ts_plot
end
legend('jpl','gfz','csr','f');