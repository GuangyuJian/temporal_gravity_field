function [sf]=SHS(sol_tgf,sol_shc,unit)
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
sol_filter=sol_tgf.sol_filter;
study_basin=sol_tgf.study_basin;
fir=study_basin.fir;
ceta=study_basin.ceta;

if strcmp(unit,'ewh (m)')
    sol_shc.change_unit('mc');
    shc=sol_shc.storage;
end

maxn=sol_filter.maxn;

ntime=length(shc);
nfir=length(fir);
nceta=length(ceta);

en=1+(maxn+3)*(maxn)/2;

cmf=sol_tgf.cmf(:,1:en);
smf=sol_tgf.smf(:,1:en);
pnm=sol_tgf.pnm(1:en,:);

if nfir~=size(cmf,1)
    error();
end

% pre-assigan memory space
value=zeros(nceta,nfir,ntime);

 temp=zeros(en,nceta);

for t=1:ntime
    cnm=shc(t).cnm(1:1:en);
    snm=shc(t).snm(1:1:en);

    for i=1:nceta
        temp(1:en,i)=cnm.*pnm(1:en,i);
    end
    value(:,:,t)= ( cmf* temp)';
    for i=1:nceta
        temp(1:en,i)=snm.*pnm(1:en,i);
    end
    value(:,:,t)= value(:,:,t)+(smf* temp )';
end

sf=sol_sf(value,unit,fir,ceta);

end

