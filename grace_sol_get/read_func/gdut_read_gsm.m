function [C,S,C_Sigma,S_Sigma,time,int_year,int_month]=gdut_read_gsm(dir_in,file_name,nmax)
%  [C,S,C_Sigma,S_Sigma]=gdut_read_gsm(dir_in,file_name,nmax);
% this function reads a single file(*gfc)
%----------------------------------------------------------------------------
% In   :    full path   [char] full path
%           file_name   [char] filename
%           nmax        [1x1] maximum degree in files
% Out  :
%           C\S             [1x en] shpherical harmonic coefficient (SHC)
%           C_Sigma\S_Sigma [1x en] formal standard deviation of SHC
%
%           both vector are storagee in degree-rank form
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-11
% MATnAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%
%
% external project:
% GRACE_Matlab_Toolbox-master
%   --->gmt_get_mon_day
%   --->gmt_readgsm (part code)
% Acknowledgement：
% Thanks for the contribution of Professor FengWei
%**************************************************************************

if nmax>200
    f = msgbox('too larger nmax for your current function');
end


% find the end of head file
path=[dir_in,file_name];
fid=fopen(path,'r');
tline=fgetl(fid);
flag=strfind(tline,'end_of_head');

sum=1;
while isempty(flag)
    tline = fgetl(fid);
    flag=strfind(tline,'end_of_head');
    sum=sum+1;
    if sum>1000
        disp(path);
        disp('********************************************');
        error('over 1000 rows, cannot find "end_of_head"');
    end
end
fclose all;
disp('********************************************');
disp(['gdut_read_gsm: " ' file_name '"']);
%read
[ n ,  m,c, s, sigmac, sigmas  ]=textread(path,'%*s %f %f %f %f %f %f' , 'headerlines', sum);

en=1+(nmax+3)*(nmax)/2;
C=zeros(en,1);
S=zeros(en,1);
C(1,1)=1;
C_Sigma=zeros(en,1);
S_Sigma=zeros(en,1);

for loc=1:length(n)
    %  en=1+(nmax+3)*(nmax)/2-l;
    nn=n(loc);
    mm=m(loc);
    nm=(nn^2+nn+2)/2+mm;

    %     for checking
    %     nnn(nm,1)=nn;
    %     mmm(nm,1)=mm;

    C(nm,1)=c(loc);
    S(nm,1)=s(loc);
    C_Sigma(nm,1)=sigmac(loc);
    S_Sigma(nm,1)=sigmas(loc);
end

[year1,year2,day1,day2]= read_yyyyddd(file_name);
[meanday,time,int_year]=gdut_get_mean_day(year1,year2,day1,day2);
% meanday     = round(meanday);
int_month   = yds2md(int_year,meanday);

% time        = year1 + meanday/365.;
% meanday     = round(meanday);
% int_year    = year1;
% int_month   = gmt_get_mon_day(year1,meanday);
% int_month   = gmt_get_mon_day(year1,meanday); %modify in 20240205 kj



end

%--------------------------------------------------
function[year1,year2,day1,day2]= read_yyyyddd(file_name)

tempstr=file_name(1:3);

switch tempstr
    case {'GSM','GAD','GAC','GAA'}
        year1 = str2num(file_name(7:10));
        year2 = str2num(file_name(15:18));
        day1  = str2num(file_name(11:13));
        day2  = str2num(file_name(19:21));
    case {'kfi'}
        tempstr2=file_name(1:11);
        if  strcmp(file_name(1:11),'kfilter_DDK')
            year1 = str2num(file_name(20:23));
            year2 = str2num(file_name(28:31));
            day1  = str2num(file_name(24:26));
            day2  = str2num(file_name(32:34));
        else
            error(['check ' file_name]);
        end
    otherwise
        disp(file_name);
        error('gdut_read_gsm: cannot find right type');
end


end
