function [time,rc20, rc20_sgima,rc30,rc30_sigma]=gdut_read_c20c30(dir_in)
%   [time,rc20, rc20_sgima,rc30,rc30_sigma]=gdut_read_c20c30(dir_in)
%---------------------------------------------------------------------------
% In   :
%       dir_in  [str]    path of the TN-14_C30_C20_GSFC_SLR.txt
% Out  :
%       times       [iix1]   vector of the time at the middle (year+fraction) 
%       rc20        [iix1]   column vector full filled with c20
%       rc30        [iix1]   column vector full filled with c30
%       rc20_sgima  [iix1]   column vector full filled with (c20)  sigma
%       rc30_sigma  [iix1]   column vector full filled with (c30)  sigma
%       
%       e.g., output0 is storaged as 
%                         [c20(1) ]
%                         [```````]
%                         [c20(i) ]
%                         [```````]
%                         [c20(ii)]
%       notes
%       i is the time index and row index.
%       ii is the total number of the shc (c10/c11/s10/s11).
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-11
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************


% find the end of head file
dir_in;
fid=fopen(dir_in,'r');
tline=fgetl(fid);
flag=strfind(tline,'Product:');

sum=1;
while isempty(flag)
    tline = fgetl(fid);
    flag=strfind(tline,'Product:');
    sum=sum+1;
    if sum>1000
        disp(path);
        disp('********************************************');
        error('over 1000 rows, cannot find "Product:"');
    end
end
fclose all;


[ times,rc20, rc20_sgima,rc30,rc30_sigma,timee   ]=textread(dir_in,'%*f %f %f %*f %f %f %*f %f %*f %f' , 'headerlines', sum);

time=(times+timee)/2;
clear times timee;

rc20_sgima=rc20_sgima*1.0E-10;
rc30_sigma=rc30_sigma*1.0E-10;


show_time_tag();
disp(['gdut_read_c20c30:  ' dir_in]);
pause(0.2);


end

