function [sol_shc_vmds]=gdut_external_vmds(sol_shc_in)                               
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
myf=sol_filter(60);
myf.set_filter('none');
basin=study_basin(1);
[sf]=shc2sf(sol_shc_in,myf,basin,'mc');
%% VMDS滤波
my_addpath('E:\github_desktop\test\external_module\GRACE_Filter_VMDS-main\');
k=6;
alpha=500;
loc=[1:4];
%%
for tt=1:length(sf.time)
    tt
[ewhvmd,~,~] =vmd_grace_mass_field_v3(sf.value(:,:,tt),k,alpha);
obs_vmd(:,:,tt)=sum(ewhvmd(:,:,loc),3);
end

sf.value=obs_vmd;
sol_shc_vmds=sf2shc(sf,myf,basin,'gc');
                             
end

