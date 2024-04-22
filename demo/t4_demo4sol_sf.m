% demo4sol_sf
% 给定滤波器和研究区域
% 就能创建时变重力场方案
% 通过这个时变重力场方案得到后续的球面函数对象
clear;
%%
clear
load('alpha_my_basin.mat');
load('alpha_csr_my_shc.mat')
load('alpha_my_filter.mat');

%% 从sol_shc对象计算球面函数
%  即创建sol_sf对象
my_basin=study_basin(1);
myf=sol_filter(60);
myf.set_filter('fan',300);
[sf]=csr_shc.shc2sf(myf,my_basin,'mc');
%% %有一定范围 默认显示全球
sf.show_range=[105 120 20 40];
%% 需要下载m_map工具箱
for tt=1:1:2
    nexttile;
    sf.obs2map_tt(tt,[-200 200])
    title([ sf.int_year(tt)  sf.int_month(tt) ])
end

%%

%%
sf.get_harmonic;

figure;
sf.harmonic2map('aa',[0 150]);
colormap(jet)
%%

sf.sf2harmonic([2001,2022]);
figure;
sf.harmonic2map('aa',[0 150]);
colormap(jet)
%% 根据sol_sf重新生成sol_shc对象 毕设可以考虑不看
% 即做球谐展开
% 用于频谱研究
[my_shc]=sf2shc(sf,myf,my_basin,'gc');
% 注意my_shc与csr_shc不一样，当前面用了滤波
%%
[sf2]=shc2sf(my_shc,myf,my_basin,'mc');
%%  sol_shc和study_basin对象创建区域时间序列
% 获得sol_ts对象 这里计算了珠江流域的流域均值
myts=sf2ts(sf,my_basin);
%% 
f=figure('position',[100 200 1000 500]);
myts.ts_plot;
%% 计算时间序列的谐波信息
trange=[2001 2017]; %也可以不指定
myts.tf2harmonic(trange);
myts.harmonic
disp('周年振幅（mm）、周年相位（°）、半周年振幅（mm）、半周年相位（°）、趋势（mm/yr）');
disp('估计值  —— 残差估计的不确定度' );
 %也可以不指定
myts.tf2harmonic();
myts.harmonic
%%
% 正演
myf.set_filter('gauss',300);
myf.pre_destrip(1,4,6);
[sf]=csr_shc.shc2sf(myf,my_basin,'mc');
 [valuefm,rms_it]=fm_unc(sf.value,60,myf.wnm,my_basin.mask);

sf.value=valuefm;
mytsfm=sf2ts(sf,my_basin);

f=figure('position',[100 200 1000 500]);
myts.ts_plot;
hold on;
mytsfm.ts_plot;