function [sol_shc_mvmds]=gdut_external_mvmds(sol_shc_in,k_max,alpha,wk_max)
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
% date: 2024-02-03
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
clc;
myf=sol_filter(60);
myf.set_filter('none');
basin=study_basin(1);
[sf]=shc2sf(sol_shc_in,myf,basin,'mc');
%% VMDS滤波
my_addpath('E:\github_desktop\test\external_module\GRACE_Filter_MVMDS-main\');
if nargin==1
k_max=6;
alpha=500;
wk_max=0.1;
end

ds_flag=1;
%%
for tt=1:size(sf.value,3)
    tt
    [signal,~]=my_MVMDS_omega_ou(sf.value(:,:,tt),k_max,alpha,ds_flag,wk_max);
    obs_vmd(:,:,tt)=signal;
end

sf.value=obs_vmd;
sol_shc_mvmds=sf2shc(sf,myf,basin,'gc');

end

