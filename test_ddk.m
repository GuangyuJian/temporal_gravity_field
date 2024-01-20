[clm]=storage_shc2clm(csr_shc.storage(1),60);         
%%
my_addpath('E:\github_desktop\test\temporal_gravity_field\ddk_module')
%%
maxn=60;
[sc]=storage_clm2sc(clm, maxn);
cs=storage_sc2cs(sc);
shc_ddkformat = gmt_cs2ddkformat(cs);
dataDDK=gmt_destriping_ddk(4,shc_ddkformat);
%%
[ddk_shc]=storage_shct2ddk_shc(csr_shc.storage(1),60);
%%
% [shct]=storage_shc_ddk2shct(shc_ddkformat);
