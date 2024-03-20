function [res,rms_oor]=get_res(time,trange,obs)
% using this func, you can get the open ocean redisual (oor) in each month
% we need three input
%  time
%  obs (i.e., observations)
%  resolutions of obs;
% then this func output also three vals
% rms_oor :spatial rms of residual
% oor_mean : spatial mean of rms_oor over open ocean
% oor_rms_tws: spatial mean of oor by cos-latitude weight in each month

%  note：in gernal, this statistical information of OOR 
% using various resolution is the same and stable 
% when these resolutions better than GRACE actual resolutions.
% Ref:Error Assessment of GRACE and GRACE Follow-On Mass Change



% clear r resolution;
%-----------------------------------------
% loading basic val of FFT for futher high-pass filtering

ds=get_ds(size(obs,1),size(obs,2)); %spatial weight
t1=gdut_uniform_time(trange); %time epoch of missing month
loc=find(time(1)-1/48<t1&t1<=time(end)+1/48);

t1=t1(loc);


Fs=12; %sample frequency (a cycle mean 12 samples) ,in this work, it is 12 months (1-year)

T = 1/Fs; %period
L=length(t1); % total month

f = Fs*(0:(L/2))/L;
f=1./f;

%-----------------------------------------
rms_oor=zeros(size(obs,1),size(obs,2)); % pre-assign memory for rms_oor

% two cycle in longititude and latitude direction
for r=1:size(obs,1)
    for c=1:size(obs,2)
        temp=obs(r,c,:);
        [temp]=get_residual(time,temp); % unweight fitting for residual
        temp=interp1_t2(time,temp(:),t1); %fitting missing value.
        temp=temp(:);

        X = temp;
        Y = fft(X);

        low_filter=ones(floor(L/2)+1,1);
        lc=find(f>=1); %cut off one-year
        low_filter(lc)=0;
        lf=[low_filter(:); flipud(low_filter(2:end))];
        X2=ifft(Y.*lf); %filtering and inversion fft
        res(r,c,:)=X2; % redisual in each month
%         rms_oor(r,c,:)=rms(X2);

    end
end

res=res(:,:,loc);
rms_oor=rms(res,3);
end