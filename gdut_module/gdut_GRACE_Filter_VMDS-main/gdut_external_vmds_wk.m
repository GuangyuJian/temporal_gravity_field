function [sol_shc_vmds,sol_wk,info,shcvmds]=gdut_external_vmds_wk(sol_shc_in,k_max,alpha,wk_max)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-25
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
%% 读取球谐系数并处理


%% 计算球面函数（无滤波）
clc;
myf=sol_filter(sol_shc_in.maxn);
myf.set_filter('none');
myb=study_basin(1);

[sf]=shc2sf(sol_shc_in,myf,myb,'mc');
%% VMDS滤波
my_addpath('E:\github_desktop\test\external_module\GRACE_Filter_VMDS-main\');
% k=6;
% alpha=500;
% loc=[1:4];
%%
for tt=1:length(sf.time)
    tt
    [ewhvmd,~,~,info(tt)] =vmd_grace_mass_field_wk(sf.value(:,:,tt),k_max,alpha);
    wk=info(tt).CentralFrequencies;
    wk=wk(end:-1:1);
    loc=find(wk<wk_max);
    loc=[1 ;loc+1];
    temp=sol_sf(ewhvmd(:,:,2:end),'ewh (mm)',myb.fir,myb.ceta);
    shcvmds(tt)=temp.sf2shc(myf,myb,'gc');
    obs_vmd(:,:,tt)=sum(ewhvmd(:,:,loc),3);
    sol_wk(:,tt)=wk;
   
end


sf.value=obs_vmd;
sol_shc_vmds=sf2shc(sf,myf,myb,'gc');

end

