function [output0,output1, times,  timee ]=gdut_read_degree1(dir_in)
% [output0,output1, times,  timee ]=gdut_read_degree1(dir_in)
% this function reads the shc of degree1 for TN-13_GEOC_CSR_RL0602.txt
%----------------------------------------------------------------------------
% In   :
%       dir_in  [str]   full path of the TN-13_GEOC_CSR_RL0602.txt
% Out  :
%       output0 [iix4]   matrix full filled with shc(c10 s10) and their sigma
%       output1 [iix4]   matrix full filled with shc(c11 s11) and their sigma
%
%       e.g., output0 is storaged as
%                         [c10(1) 	s10(1) 	c10_sigma(1)  	s10_sigma(1)]
%                         [``````````````````````````````````````							]
%                         [c10(i) 		s10(i) 	c10_sigma(i)  		s10_sigma(i)]
%                         [``````````````````````````````````````							]
%                         [c10(ii) 	s10(ii) 	c10_sigma(ii)  	s10_sigma(ii)]
%
%       i is the time index and row index.
%       ii is the total number of the shc (c10/c11/s10/s11).
%
%       times   [iix1]   vector of the time at the beginning(year+fraction)
%       timee   [iix1]   vector of the time in the end(year+fraction)
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-13
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

% dir_in;
fid=fopen(dir_in,'r');
tline=fgetl(fid);
flag=strfind(tline,'end of header');

sum=1;
while isempty(flag)
    tline = fgetl(fid);
    flag=strfind(tline,'end of header');
    sum=sum+1;
    if sum>1000
        disp(path);
        disp('********************************************');
        error('over 1000 rows, cannot find "Product:"');
    end
end
fclose all;

[   rc , rs , rc_sigma , rs_sigma , times,  timee  ]=textread(dir_in,'%*s %*f %*f %f %f %f %f %f %f' , 'headerlines', sum);

output=[ rc rs rc_sigma,rs_sigma];
output0=output(1:2:end,:);
output1=output(2:2:end,:);

times2=num2str(times);
timee2=num2str(timee);

for k=1:length(times)
    int_year=str2num(times2(k,1:4));
    dayall=365+is_leap_year(int_year);
    
    mon=str2num(times2(k,5:6));
    day=str2num(times2(k,7:8));
    [ days ] = gmt_get_days(int_year,mon,day );
    times(k)=int_year+days/dayall;

    int_year=str2num(timee2(k,1:4));
    dayall=365+is_leap_year(int_year);

    mon=str2num(timee2(k,5:6));
    day=str2num(timee2(k,7:8));
    [ days ] = gmt_get_days(int_year,mon,day);
    timee(k)=int_year+days/dayall;

end
times=times(1:2:end);
timee=timee(1:2:end);

show_time_tag();
disp(['gdut_read_degree1:  ' dir_in]);
pause(0.2);


end

