function [my_shc]=sf2shc(mysf,myf,myb,type)
% [my_shc]=sf2shc(mysf,myf,myb,type)
%----------------------------------------------------------------------------
% In   :    mysf    [1x1] @sol_sf 
%           myf     [1x1] @sol_filter
%           myb     [1x1] @study_basin
%           type    [1xn] char
%                           option: 'mc' 'gc' 'gdc'
% Out  :
%           my_shc  [1x1] @sol_shc a object truncated up to degree maxn
%           maxn derived from myf
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
% myf=sol_tgf.myf;
% myb=sol_tgf.myb;

if nargin==1
myf=sol_filter(96);
res=180/size(mysf.value,1);
myb=study_basin(res);
type='gc';
end

fir=myb.fir;
ceta=myb.ceta;

maxn=myf.maxn;
ntime=size(mysf.value,3);
%------- PnMl---------------

% prepare info of spherical grid
nfir=length(fir);
nceta=length(ceta);
% prepare Ylm (spherical basis function)
[pnm,cmf,smf,ds]=get_sob(myf,myb);

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
    [shc(t).cnm,shc(t).snm]=gdut_sha(mysf.value(:,:,t),cmf,smf,pnm,maxn,ds);
end

%% create sf object (spherical function)
switch mysf.unit
    case 'ewh (mm)'
    my_shc=sol_shc(shc,maxn,'shc','mc');
    case 'uGal'
    my_shc=sol_shc(shc,maxn,'shc','gdc');
end
% set time info
my_shc.change_type(type);
my_shc.set_time(mysf.time,mysf.int_year,mysf.int_month)
my_shc.append_info('----------------------');
my_shc.append_info([mysf.info]);

% show_time_tag;
% disp('sf2shc: shc is done');
end

