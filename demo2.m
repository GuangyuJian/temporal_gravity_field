%%
clc;
ds=mysolution.ds;
value1=sf.value(:,:,1);
cmf=mysolution.cmf;
smf=mysolution.smf;
pnm=mysolution.pnm;
maxn=60;

[cnm,snm]=gdut_sha(value1,cmf,smf,pnm,maxn,ds);
%%
[sfvalue]=gdut_shs(cnm,snm,cmf,smf,pnm,maxn);