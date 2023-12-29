clear;
root_path=dir;
my_addpath(root_path(1).folder);
clc;

my_addpath('\@sol_filter\');
%%
clc;
myf=sol_filter(60);
myf.set_filter('gauss',300);
disp(myf)
%%
myf.wnm_plot;
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
