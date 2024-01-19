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
figure('Position',[0 100 800*2 500]);
close 
nexttile;
myf.wnm_plot;


nexttile;
myf.wn_plot;

nexttile;
myf.wn_semilogy;


nexttile;
myf.wnm_imagesc;
%%