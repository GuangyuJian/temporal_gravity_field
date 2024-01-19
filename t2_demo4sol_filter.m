clear;
clc;
my_addpath('E:\github_desktop\test\temporal_gravity_field\');
clc;

%%
clc;
myf=sol_filter(60);
myf.set_filter('gauss',300);
disp(myf)

%%
close 
myf.wnm_imagesc;
%%
close all;
figure('Position',[200 100 800 400]);
tiledlayout(1,1,"TileSpacing","compact")
nexttile;

for k=1:8
    rn=k*100;
    myf.set_filter('gauss',rn);
    myf.wnm_plot;
    hold on;
    str_legend{k}=num2str(rn);
end
legend(str_legend)

%%
close all;
figure('Position',[0 100 800*2 500]);
tiledlayout(2,4,"TileSpacing","compact")


for k=1:8
    nexttile;
    rn=k*100;
    myf.set_filter('fan',rn);
    myf.wnm_imagesc;
    hold on;
    str_legend{k}=num2str(rn);
    title(str_legend{k});
end
legend(str_legend)
%%
%% 显示滤波器的形状
% this demo show that the mysolutions.sol_filter would change
% with the myf unless you recreat a new object named myf.
%  they share the same storage space.
f=figure('position',[100 200 1000 500]);
myf.set_filter('gauss',200);
myf.wnm_plot
myf.set_filter('rec',2.5,'gauss',250);
hold on;
myf.wnm_plot
diary off;
%%
show_time_tag;
% dialog;
pre_fix='alpha_';
filename=[pre_fix 'my_filter'];
save([filename],"myf");