clear;
clc;
path='F:\V4\外部工具箱\SSAS-GRACE-filter-master\SSAS_final_result\';
Filename=dir(fullfile(path,'CSR*txt'));
btemp=readmatrix('GGM05C.txt');%http://icgem.gfz-potsdam.de/tom_longtime
bc=btemp(1:1891,3);
bs=btemp(1:1891,4);

for k=1:195
    temp=readmatrix([path Filename(k).name]);
    SH(k).C= temp(:,3)+bc;
    SH(k).S= temp(:,4)+bs;
end
%%

load Gauss_0_0_None_csr60r025.mat;
solcsr.pre_destrip(0,4,6);
solcsr.pre_filter('Gauss',0);
solcsr.get_Coe({'only_coe'});
[ewhnone]=SH2EWH(solcsr,solcsr.SH,'ewh');
%%
solcsr.SH=SH;
solcsr.get_Coe({'de_background'});
[ewhssas]=SH2EWH(solcsr,solcsr.SH,'ewh');
%%
% mask=zeros(720,1440);
% mask(120:600,:)=1;
% imagesc((ewhnone(:,:,1)-ewhssas(:,:,1)).*mask,[-500 500]);
%%
for k=1:195
    [sh_st(k).C,sh_st(k).S]=SA_SH_Tool(mask.*(ewhnone(:,:,k)-ewhssas(:,:,k)),solcsr);
end
%%
load csrmmask.mat
%%
tt=solcsr.time(1:162);
S1 = 300*sin(2*pi*tt) + 50*sin(pi*tt)+30*(tt-tt(1));
S2 = 300*sin(2*pi*tt) + 50*sin(pi*tt)+30*(tt-tt(1));
S3 = 300*sin(2*pi*tt) + 50*sin(pi*tt)+30*(tt-tt(1));
S4 = 300*sin(2*pi*tt) + 50*sin(pi*tt)+30*(tt-tt(1));
S5 = 300*sin(2*pi*tt) + 50*sin(pi*tt)+30*(tt-tt(1));
%
% S1=S1+100*randn(size(S1));
% S2=S2+100*randn(size(S1));
% S3=S3+100*randn(size(S1));
% S4=S4+100*randn(size(S1));
% S5=S5+100*randn(size(S1));

% plot(tt,S1,tt,S2);
%%
clc;
mask_sim=zeros(720,1440,162);
for tt=1:162
    dd=20;
    mask_sim(340:340+dd,200:200+dd,tt)=1*S1(tt);
    mask_sim(500:500+dd,150:150+dd,tt)=1*S2(tt);
    mask_sim(490:520+dd,650:650+dd,tt)=1*S3(tt);
    % mask_sim(290:300+dd,560:550+dd)=1;
    for r=1:20
        mask_sim(390+r,1000+r*2:1020+r*2,tt)=1*S4(tt);
    end
    
    for r=1:20
        mask_sim(190+r,550-r*2:580-r*2,tt)=1*S5(tt);
    end
    
end
% imagesc(mask_sim+land_mask);
% axis equal
%%

%%
load('true_162_withocean.mat')
true=mask_sim+true;
%%
imagesc(true(:,:,1),[-300 300]);
%%
solcsr.set_Resolution(0.25);
solcsr.get_Coe({'only_coe'});
for k=1:162
    [sh_tr(k).C,sh_tr(k).S]=SA_SH_Tool(true(:,:,k),solcsr);
end
%%
sc=0;
for k=1:162
    sh_obs(k).C=sh_tr(k).C+sh_st(k).C*sc;
    sh_obs(k).S=sh_tr(k).S+sh_st(k).S*sc;
end

clc;
for k=1:162
    sh_obs2(:,k)=[sh_obs(k).C ;sh_obs(k).S] ;
end
%%
[fin_sh]=shc_temporal_vmd(sh_obs2,60);
[shc_obs3]=sh2shc(fin_sh);

clc;
solcsr.set_Resolution(1);
solcsr.get_Coe({'only_coe'});
tt=10;
[ewhnone]=SH2EWH(solcsr,sh_obs(tt),'ewh');
[ewhnone2]=SH2EWH(solcsr,shc_obs3(tt),'ewh');
[ewhnone3]=SH2EWH(solcsr,sh_tr(tt),'ewh');
[ewhnone4]=SH2EWH(solcsr,sh_st(tt),'ewh');

subplot(3,2,1);
imagesc(ewhnone,[-300 300]);

subplot(3,2,2);
imagesc(ewhnone2,[-300 300]);

subplot(3,2,3);
imagesc(ewhnone3,[-300 300]);

subplot(3,2,4);
imagesc(ewhnone2-ewhnone3,[-300 300]);


subplot(3,2,4);
imagesc(ewhnone-ewhnone2,[-300 300]);

subplot(3,2,5);
imagesc(ewhnone-ewhnone3,[-300 300]);

subplot(3,2,6);
imagesc(ewhnone2-ewhnone3,[-300 300]);
%%
load glboudary.mat
solcsr.get_mask(gl(:,1),gl(:,2));
solcsr.set_Resolution(0.25);
solcsr.get_Coe({'only_coe'});

% solcsr.mask=;
[ewhnone]=SH2EWH(solcsr,sh_tr,'ewh');
twstr=Region_2_TWS(ewhnone,solcsr);
clear ewhnone

[ewhnone]=SH2EWH(solcsr,sh_obs,'ewh');
twsnone=Region_2_TWS(ewhnone,solcsr);
clear ewhnone

[ewhnone2]=SH2EWH(solcsr,shc_obs3,'ewh');
twsnone2=Region_2_TWS(ewhnone2,solcsr);
clear ewhnone2


tt=solcsr.time(1:162);
ger_plot(tt,twstr,tt,twsnone,tt,twsnone2);legend('tr','st','vmd');
%%
plot(tt,twstr-twsnone2);