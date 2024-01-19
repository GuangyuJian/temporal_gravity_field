function [sf]=shc2sf(sol_shc,sol_filter,study_basin,type)
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
% sol_filter=sol_tgf.sol_filter;
% study_basin=sol_tgf.study_basin;

fir=study_basin.fir;
ceta=study_basin.ceta;
 


maxn=sol_filter.maxn;
%------- PnMl---------------
sol_shc.change_type('gc');
shc=sol_shc.storage;
ntime=length(shc);

if sol_filter.PnMl_flag==1

    disp('----------------------------')
    disp('destrping')

    for tt=1:ntime
        %         disp(sol_shc.time(tt))
        tt
        nn=sol_filter.PnMl_n;
        ll=sol_filter.PnMl_m;
        [shc(tt).cnm]=sol_filter.math_PnMl(shc(tt).cnm,nn,ll,maxn);
        [shc(tt).snm]=sol_filter.math_PnMl(shc(tt).snm,nn,ll,maxn);
    end
end

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

%----------------------
% prepare info of spherical grid
nfir=length(fir);
nceta=length(ceta);
% prepare Ylm (spherical basis function)
[pnm,cmf,smf,~]=get_sob(sol_filter,study_basin);
en=1+(maxn+3)*(maxn)/2;
% cmf=cmf(1:maxn+1,:);
% smf=smf(1:maxn+1,:);
pnm=pnm(1:en,:);
% if nfir~=size(cmf,2)
%     error();
% end
% prepare wnm
wnm=sol_filter.wnm(1:en);
%% pre-assigan memory space
value=zeros(nceta,nfir,ntime);

%% spherical harmonic synthesis
for t=1:ntime
    cnm=shc(t).cnm(1:1:en);
    snm=shc(t).snm(1:1:en);

    cnm=cnm(:).*wnm(:);
    snm=snm(:).*wnm(:);
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
sf.time=sol_shc.time;
sf.int_year=sol_shc.int_year;
sf.int_month=sol_shc.int_month;
show_time_tag;
disp('shc2sf：sf is done');

% disp(sol_filter);
end

