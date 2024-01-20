function [sf]=shc2sf(myshc,myf,myb,type)
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
% date: 2023-12-27
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************
fir=myb.fir;
ceta=myb.ceta;
maxn=myf.maxn;

myshc.change_type('gc');
shc=myshc.storage;

%% destriping and scaling
shc=in_destriping(shc,myf);
[shc]=in_scale(shc,maxn,type);

%% prepare Ylm (spherical basis function)
[pnm,cmf,smf,~]=get_sob(myf,myb);
en=get_en(maxn);
pnm=pnm(1:en,:);
cmf=cmf(1:maxn+1,:);
smf=smf(1:maxn+1,:);

%% prepare wnm
wnm=myf.wnm(1:en);
%% pre-assigan memory space
ntime=length(shc);
nfir=length(fir);
nceta=length(ceta);
value=zeros(nceta,nfir,ntime);

%% spherical harmonic synthesis
for t=1:ntime
    cnm=squeeze(  shc(t).cnm(1:1:en)  ).*wnm(:);    
    snm=squeeze(  shc(t).snm(1:1:en)  ).*wnm(:);
    [value(:,:,t)]=gdut_shs(cnm,snm,cmf,smf,pnm,maxn);
end

%% create sf object (spherical function)
switch type
    case 'mc'
        unit='ewh (mm)';
    case 'gdc'
        unit='uGal';
end

sf=sol_sf(value,unit,fir,ceta);
% set time info
sf.time=myshc.time;
sf.int_year=myshc.int_year;
sf.int_month=myshc.int_month;
sf.show_range='global';
show_time_tag;
disp('shc2sf：sf is done');
% sf.append_info([myf]);
% sf.append_info([myb]);
% disp(myf);
end

function shc=in_destriping(shc,myf)
maxn=myf.maxn;
ntime=length(shc);

switch myf.destrip_flag

    case 1
        disp('----------------------------')
        disp('destrping')
        for tt=1:ntime
            nn=myf.PnMl_n;
            ll=myf.PnMl_m;
            [shc(tt).cnm]=sol_filter.st_PnMl(shc(tt).cnm,nn,ll,maxn);
            [shc(tt).snm]=sol_filter.st_PnMl(shc(tt).snm,nn,ll,maxn);
        end

    case 2 %fw
        for tt=1:ntime
            [clm]=storage_shc2clm(shc(tt),maxn);
            [sc]=storage_clm2sc(clm, maxn);
            [shc(tt)]=sol_filter.st_destriping(sc,myf.fw_destrip_type);
        end

    case 3 %ddk
        [shc_ddk]=storage_shct2ddk(shc,maxn);
        dataDDK=gmt_destriping_ddk(myf.ddk_type,shc_ddk);
        shc=storage_ddk2shct(dataDDK);
    otherwise
%         error('!')
    disp('not desriping');
end

end

function [shc]=in_scale(shc,maxn,type)
ntime=length(shc);
switch type
    case 'gdc'
        for k=1:ntime
            [shc(k).cnm]=sol_shc.scf_gc2gdc(shc(k).cnm,maxn);
            [shc(k).snm]=sol_shc.scf_gc2gdc(shc(k).snm,maxn);
        end
    case 'mc'
        for k=1:ntime
            [shc(k).cnm]=sol_shc.scf_gc2mc(shc(k).cnm,maxn);
            [shc(k).snm]=sol_shc.scf_gc2mc(shc(k).snm,maxn);
        end
end
end