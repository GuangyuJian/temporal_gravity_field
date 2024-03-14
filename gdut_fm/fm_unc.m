function [output,rms_it]=fm_unc(value,maxn,wnm,mask)
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
% date: 2024-01-23
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
load('orog.mat');
ntime=size(value,3);
d=180/size(value,1);

myf=sol_filter(maxn);
myb=study_basin(d);
[pnm,cmf,smf,ds]=get_sob(myf,myb);
en=1+(maxn+3)*(maxn)/2;
cmf=cmf(1:maxn+1,:);
smf=smf(1:maxn+1,:);
pnm=pnm(1:en,:);

rms_it=zeros(ntime,100);
for t=1:ntime
    model0=value(:,:,t);
    rms_dif=10000;
    model1=model0;

    nit=0;
    t
    while rms_dif>1&nit<=100
        nit=nit+1;
        myb.mask=ocean_mask;
        [~,so]=sol_sf.grid2ts(model1,myb);

        myb.mask=land_mask;
        [ml,sl]=sol_sf.grid2ts(model1,myb);
        mo=-ml*so/sl;

        model1=model1.*land_mask+mo.*ocean_mask;
        [cnm,snm]=gdut_sha(model1,cmf,smf,pnm,maxn,ds);

        cnm=squeeze(  cnm(1:1:en)  ).*wnm(:);
        snm=squeeze(  snm(1:1:en)  ).*wnm(:);
        [model2]=gdut_shs(cnm,snm,cmf,smf,pnm,maxn);

        dif_obs=model0-model2;
        model1=model1+1*dif_obs;

        myb.mask=mask;
        [rms_dif]=sol_sf.grid2rms(dif_obs,myb);
        rms_it(t,nit)=rms_dif;
%         rms_dif
    end
    output(:,:,t)=model1;
end

