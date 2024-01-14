function [record]=replace_c20c30(grace_shc,dir_in)
%[record]=replace_c20c30(grace_shc,dir_in)
%----------------------------------------------------------------------------
% In   : 
%       grace_shc  [sol_shc] a object of grace_gsm shc
%       dir_in     [str]    path of the TN-14_C30_C20_GSFC_SLR.txt
% 
% Out  :
%       record      [1xnn] record the replacement
%       notes: nn means the total month of shc from grace_shc objecy
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

% nmax=60;
[time,rc20, rc20_sgima,rc30,rc30_sigma]=gdut_read_c20c30(dir_in);
record=[];
loc=0;
temptime=grace_shc.time;
for tt=1:length(grace_shc.time)
%     tt
    tempdif=abs(temptime(tt)-time);
    [m,i]=min(tempdif);
    if m<1/24
        grace_shc.storage(tt).cnm(4)=rc20(i);
        grace_shc.storage(tt).cnm_sigma(4)=rc20_sgima(i);

        if ~isnan(rc30(i))
            grace_shc.storage(tt).cnm(7)=rc30(i);
            grace_shc.storage(tt).cnm_sigma(7)=rc30_sigma(i);
        end
        record=[tt record ];
    else
        error('replace_c20c30: can not find a corresponding c20 c30');
    end
end
% show_time_tag;
disp('replace_c20c30: c20 c30 is replaced');
message=sprintf('------------------\ndir of c20c30: %s',dir_in);
grace_shc.append_info(message);
end

