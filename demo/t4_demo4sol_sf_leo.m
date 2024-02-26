% demo4sol_sf
% 给定滤波器和研究区域
% 就能创建时变重力场方案
% 通过这个时变重力场方案得到后续的球面函数对象
clear;
%%

load('alpha_my_basin.mat');
load('alpha_leomy_shc.mat')
load('alpha_my_filter.mat');

%% 从sol_shc对象计算球面函数
%  即创建sol_sf对象
myf.set_filter('gauss',300);
myf.pre_destrip(1,4,6);
[sf]=leo_shc.shc2sf(myf,my_basin,'mc');
%% %有一定范围
sf.show_range=[60 120 10 70];
%%
for tt=1:1:12
    nexttile;
    sf.obs2map_tt(tt,[-200 200])
end
%% 根据sol_sf重新生成sol_shc对象
% 即做球谐展开
% 用于频谱研究
[my_shc]=sf2shc(sf,myf,my_basin,'gc');
% 注意my_shc与csr_shc不一样，当前面用了滤波
%%
[sf2]=shc2sf(my_shc,myf,my_basin,'mc');
%%  sol_shc和study_basin对象创建区域时间序列
% 获得sol_ts对象
myts=sf2ts(sf,my_basin);
%%
f=figure('position',[100 200 1000 500]);
myts.ts_plot