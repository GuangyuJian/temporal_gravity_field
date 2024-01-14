function []=replace_gia(grace_shc,dir_in,ts,te)
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

if ts>te
error('wrong');
end

% GIA_Address="GIA_mass0km.txt";

[cnm,snm,~]=textread(dir_in,'%f %f %f');% mm/a

time=grace_shc.time;

loc=find(time>=ts&time<=te);
baseline=mean(time(loc),'all');
time=time-baseline;
grace_shc.change_type('mc');

loc=0;
ntt=length(time);

for tt=1:ntt
            %c10 s10 and their sigma              
            grace_shc.storage(tt).cnm(:)=grace_shc.storage(tt).cnm(:)-time(tt)*cnm/1000;
            grace_shc.storage(tt).snm(:)=grace_shc.storage(tt).snm(:)-time(tt)*snm/1000;
end

grace_shc.change_type('gc');

show_time_tag;
disp('replace_gia: gia is replaced');
message=sprintf('------------------\n gia_baseline:');
grace_shc.append_info(message);
message=sprintf('start: %f end: %f',ts,te);
grace_shc.append_info(message);
end

