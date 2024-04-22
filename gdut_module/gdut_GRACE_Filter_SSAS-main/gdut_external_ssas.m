function [sol_shc_ssa]=gdut_external_ssas(sol_shc_in)
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
% date: 2024-01-18
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

my_addpath('E:\code\20240127\test\temporal_gravity_field\GRACE_Filter_SSAS-main\')
a = load('data/csr06_gsm_2004-12_2005-02.mat'); % SH
SH0 = cSH(a.SH); % convert to the data format used here.
SH0 = SH0(1);

Njump=20;
M=40;
K=20;
ipolar_weight=1;
igap_sumatra=1;
clc;

shc=sol_shc_in.storage;
maxn=sol_shc_in.maxn;

for tt=1:length(shc)
    tt

    [ SH0.C,SH0.S]=   ssas_shc2ccss(shc(tt),maxn);
    %----------------------------------------ssas
    if maxn==60
    [SH_filter, LLZ_noise]=fun_ssa_spatial_filter( SH0, ...
        'Njump',Njump, 'M',M, 'K',K, ...
        'ipolar_weight',ipolar_weight, 'igap_sumatra',igap_sumatra);
    elseif maxn==96
    [SH_filter, LLZ_noise]=fun_ssa_spatial_filter_do96( SH0, ...
        'Njump',Njump, 'M',M, 'K',K, ...
        'ipolar_weight',ipolar_weight, 'igap_sumatra',igap_sumatra);
    end
    %     [LLZ_ssas]=SSAS_SH2GR_block(SH_filter);
    [LLZ_ssas]=LLZ_forward_ns(SH_filter, 'to', 'gr','ran',[0,360,-90,90],'grid','block');
    %----------------------------------------
    %----------------------------------------
    %----------------------------------------gd2ccss
    %     [cSH_ssas]=SSAS_GR2SH_block_do60(LLZ_ssas);
    cSH_ssas=LLZ_inverse_ns(LLZ_ssas,maxn,'gr');
    %----------------------------------------ccss2shc
    [shc_ssas(tt)]=ssas_ccss2shc(cSH_ssas.C,cSH_ssas.S);
end
sol_shc_ssa=sol_shc(shc_ssas,maxn,'shc','gc');
sol_shc_ssa.set_time(sol_shc_in.time,sol_shc_in.int_year,sol_shc_in.int_month);
end


function[shc]=ssas_ccss2shc(cc,ss)
Lmax=size(cc,1)-1;
for l=0:Lmax
    st=(l+1)/2*(l);
    for m=0:l
        lm=st+m+1;
        shc.cnm(lm,1)=cc(l+1,m+1);
        %         =C(lm);
        %         if m~=0
        shc.snm(lm,1)=ss(l+1,m+1);
        %         end
    end
end
end

function[cc,ss]=ssas_shc2ccss(shc,maxn)

cc=zeros(maxn+1);
ss=zeros(maxn+1);

for nn=0:maxn
    st=(nn+1)/2*(nn);
    for mm=0:nn
        lm=st+mm+1;
        cc(nn+1,mm+1)=shc.cnm(lm,1);
        ss(nn+1,mm+1)=shc.snm(lm,1);

    end
end

end