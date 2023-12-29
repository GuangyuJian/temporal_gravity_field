my_addpath('\@study_basin');
my_addpath('E:\github_desktop\test\temporal_gravity_field\demo_test\');
%%
s=shaperead('F:\data\10 basin_shpfile\中国流域划分\珠江区1：25万界线数据集（2002年）\珠江区1：25万界线数据集（2002年）\珠江区.shp');

clc;
pearl_river=study_basin(0.5);
bf1=s.X;
bc1=s.Y;
pearl_river.get_mask(bf1,bc1);
disp(pearl_river)
%%
my_addpath('E:\github_desktop\test\temporal_gravity_field')
my_addpath('\@sol_filter\');

clc;
myf=sol_filter(60);
myf.set_filter('gauss',300);
disp(myf)
%%
clc
mysolution=sol_tgf(myf,pearl_river);
clc;
%%
shc(1).cnm=sh_jpl60(1).C;
shc(1).snm=sh_jpl60(1).S;

[sf]=SHS(mysolution,shc,'ewh (mm)');
%%

%%
% this demo show that the mysolutions.sol_filter would change 
% with the myf unless you recreat a new object named myf.
%  they share the same storage space.
myf.set_filter('gauss',0);
disp(myf)


disp(mysolution.sol_filter)
%%
mysolution.sol_filter.set_filter('gauss',500)

disp(mysolution.sol_filter)
%%
[sf]=SHS(sol_tgf,shc);