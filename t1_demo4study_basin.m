clear
clc;
clc;
% 
my_addpath('...\temporal_gravity_field\');
%%
s=shaperead('test_alpha\珠江区1：25万界线数据集（2002年）\珠江区.shp');
my_basin.name='珠江流域';
%%
clc;
my_basin=study_basin(1); % 0.25 0.5 1 3
bf1=s.X;
bc1=s.Y;
%%
my_basin.get_mask(bf1,bc1);
disp(my_basin)
clear bf1 bc1 ans s;
%%
my_basin.plot_region

%% 
show_time_tag;
% dialog;
pre_fix='alpha_';
filename=[pre_fix 'my_basin'];
save([filename],"my_basin");
%%