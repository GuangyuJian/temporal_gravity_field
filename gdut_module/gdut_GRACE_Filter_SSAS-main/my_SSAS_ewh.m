function [ewhssas,shc_ssas] =my_SSAS_ewh(shc)
% 该函数对观测值执行SSAS滤波
% input: shc
% output: 
% ewhssas: filetred result 
% shc_ssas: shc of ewhssas
% 
% load('sol.mat');
load('sol_official_GGM05C.mat','solcsr');
solcsr.set_Resolution(1);
solcsr.pre_destrip(0,4,6);
solcsr.set_filter('gauss',0);
solcsr.get_Coe('only_coe');
my_addpath('F:\V4\toolbox\SSAS-GRACE-filter-master\')
a = load('data/csr06_gsm_2004-12_2005-02.mat'); % SH
SH0 = cSH(a.SH); % convert to the data format used here.
SH0 = SH0(1);

Njump=20;
M=40;
K=20;
ipolar_weight=1;
igap_sumatra=1;
clc;

for tt=1:length(shc)
    tt

[ SH0.C,SH0.S]=   shc2ccss(shc(tt));
%----------------------------------------ssas
[SH_filter, LLZ_noise]=fun_ssa_spatial_filter( SH0, ...
    'Njump',Njump, 'M',M, 'K',K, ...
    'ipolar_weight',ipolar_weight, 'igap_sumatra',igap_sumatra);
[LLZ_ssas]=SSAS_SH2GR_block(SH_filter);
%----------------------------------------
%----------------------------------------
%----------------------------------------gd2ccss

[cSH_ssas]=SSAS_GR2SH_block_do60(LLZ_ssas);
%----------------------------------------ccss2shc
[shc_ssas(tt)]=ccss2shc(cSH_ssas.C,cSH_ssas.S);
ewhssas(:,:,tt)=SH2EWH(solcsr,shc_ssas(tt),'ewh');

end
end