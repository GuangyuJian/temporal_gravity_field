function [my_shc]=sf2shc(sol_sf,sol_filter,study_basin,type)
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
ntime=length(sol_sf.time);
%------- PnMl---------------

% prepare info of spherical grid
nfir=length(fir);
nceta=length(ceta);
% prepare Ylm (spherical basis function)
[pnm,cmf,smf,ds]=get_sob(sol_filter,study_basin);

en=1+(maxn+3)*(maxn)/2;
cmf=cmf(1:maxn+1,:);
smf=smf(1:maxn+1,:);
pnm=pnm(1:en,:);

% if nfir~=size(cmf,2)
%     error();
% end
% prepare wnm

%% pre-assigan memory space


%% spherical harmonic synthesis
for t=1:ntime
    [shc(t).cnm,shc(t).snm]=gdut_sha(sol_sf.value(:,:,t),cmf,smf,pnm,maxn,ds);
end

%% create sf object (spherical function)
switch sol_sf.unit
    case 'ewh (mm)'
    my_shc=sol_shc(shc,maxn,'shc','mc');

end
% set time info
my_shc.change_type(type);
my_shc.time=sol_sf.time;
my_shc.int_year=sol_sf.int_year;
my_shc.int_month=sol_sf.int_month;

show_time_tag;
disp('sf2shc: shc is done');
end

