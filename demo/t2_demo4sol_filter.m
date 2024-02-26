clear;
clc;
% my_addpath('E:\github_desktop\test\temporal_gravity_field\');
clc;

%%
clc;
myf=sol_filter(60); %grace  do/60
%leo    do/40
%%
% myf.pre_destrip(1,3,10); 1
% % myf.pre_destrip_fw('chenp3m6');2
% myf.pre_destrip_ddk(1);%ddk1-8 3
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
