clear
clc;
my_addpath('\@study_basin');
my_addpath('E:\github_desktop\test\temporal_gravity_field\demo_test\');
%%
s=shaperead('F:\data\10 basin_shpfile\中国流域划分\珠江区1：25万界线数据集（2002年）\珠江区1：25万界线数据集（2002年）\珠江区.shp');
%%
clc;
pearl_river=study_basin(0.5);
bf1=s.X;
bc1=s.Y;
pearl_river.get_mask(bf1,bc1);
disp(pearl_river)
%%
pearl_river.plot_region
%%

%%
figure('Position',[200 200 1600 800]);
tiledlayout(1,2,"TileSpacing","loose");
pearl_river.plot_region
%%
