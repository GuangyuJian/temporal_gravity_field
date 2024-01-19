function [record]=replace_degree1(grace_shc,dir_in)
% [record]=replace_degree1(grace_shc,dir_in)
%----------------------------------------------------------------------------
% In   : 
%       grace_shc  [sol_shc] a object of grace_gsm shc
%       dir_in     [str]    path of the TN-13_GEOC_CSR_RL0602.txt
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

[c10s10,c11s11, times,  timee ]=gdut_read_degree1(dir_in) ;

loc=0;

temptime=grace_shc.time;
ntt=length(temptime);
nii=length(times);
lc=0;
record=[];

for tt=1:ntt
%     tt
    lc=lc+1;
    for i=lc:nii
        % tt2
        ts=(times(i,:));
        te=(timee(i,:));
        if temptime(tt)>=ts&temptime(tt)<=te
              
            %c10 s10 and their sigma              
            grace_shc.storage(tt).cnm(2)=c10s10(i,1);
            grace_shc.storage(tt).snm(2)=c10s10(i,2);

            grace_shc.storage(tt).cnm_sigma(2)=c10s10(i,3);
            grace_shc.storage(tt).snm_sigma(2)=c10s10(i,4);

            %c11 s11 and their sigma
            grace_shc.storage(tt).cnm(3)=c11s11(i,1);
            grace_shc.storage(tt).snm(3)=c11s11(i,2); 

            grace_shc.storage(tt).cnm_sigma(3)=c11s11(i,3);
            grace_shc.storage(tt).snm_sigma(3)=c11s11(i,4);

            lc=i;
            i=nii;

        end

    end
   record=[record lc]; 
end
% show_time_tag;
disp('replace_degree1: c10 c11 s10 s11 is replaced');

% message=sprintf('------------------\n replace_degree1: c10 c11 s10 s11 is replaced:');
% grace_shc.append_info(message);
message=sprintf('------------------\ndir of degree 1: %s',dir_in);
grace_shc.append_info(message);
end

