function [ss]=get_oor_rms(time,trange,obs,resolution)
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

%-----------------------------------------
%     loading open ocean mask
r=resolution;
if r==0.25
    load('mask_r025_bufferg300.mat');
    land_mask=mask_r025_bufferg300;
    ocean=1-land_mask;
    elseif r==0.5

        load('mask_r05_bufferg300.mat');
    land_mask=mask_r05_bufferg300;
    ocean=1-land_mask;
elseif r==1
    % 延拓300 km
    load mask_r1_bufferg300;
    land_mask=mask_r1_bufferg300;
    ocean=1-land_mask;
elseif r==3
    load mask_r3_bufferg300;
    land_mask=mask_r3_bufferg300;
    ocean=1-land_mask;
end

clear r resolution;
%-----------------------------------------
% loading basic val of FFT for futher high-pass filtering

ds=get_ds(size(obs,1),size(obs,2)); %spatial weight
t1=gdut_uniform_time(trange) %time epoch of missing month
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
        lc=find(f>1); %cut off one-year
        low_filter(lc)=0;
        lf=[low_filter(:); flipud(low_filter(2:end))];
        X2=ifft(Y.*lf); %filtering and inversion fft
        res(r,c,:)=X2; % redisual in each month
        rms_oor(r,c,:)=rms(X2);

        %----------------------------------画图
        %         P2 = abs(Y/L);
        %         P1 = P2(1:floor(L/2)+1);
        %         P1(2:end-1) = 2*P1(2:end-1);
        %         画图检查
        %         nexttile;
        %         TSA_fft_plot4(temp,12,[0 12],2,1);
        %         hold on;
        %         TSA_fft_plot4(X2,12,[0 12],3,1);
        %         nexttile;
        %         plot(t1,X2,t1,temp,t1,temp-X2);
    end
end

%--------------------------------------------
% spatial weight 
% WRMS
mask=ocean;
ds=get_ds(size(obs,1),size(obs,2));
for k=1
    temp=  rms_oor(:,:,k)    .*ocean  ;
    m=sum(ocean.*ds,'all');
    oor_mean(k,1)=sqrt(sum( temp.^2.*ds ,'all')/m);
end

low_mask=zeros(size(ocean));
low_mask(size(ocean,1)/3:size(ocean,1)/3*2,:)=1;
for k=1
    temp=  rms_oor(:,:,k)    .*ocean.*low_mask  ;
    m=sum(ocean.*ds,'all');
    oor_mean_low(k,1)=sqrt(sum( temp.^2.*ds ,'all')/m);
end

%--------------------------------------------
% temporal change in spatial weight of residual over ocean
for k=1:size(res,3)
    temp=  res(:,:,k)    .*ocean ;
    m=sum(mask.*ds,'all');
    oor_rms_tws(k,1)=sqrt(sum(  temp.^2.*ds ,'all')/m);
end
oor_rms_tws=interp1_t2_std(t1, oor_rms_tws,time);


for k=1:size(res,3)
    temp=  res(:,:,k)    .*ocean.*low_mask ;
    m=sum(mask.*ds,'all');
    oor_rms_tws_low(k,1)=sqrt(sum(  temp.^2.*ds ,'all')/m);
end
oor_rms_tws_low=interp1_t2_std(t1, oor_rms_tws_low,time);


low_mask=zeros(size(ocean));
low_mask(size(ocean)/4:size(ocean)/4*2,:)=1;
for k=1
    temp=  rms_oor(:,:,k)    .*ocean.*low_mask  ;
    m=sum(ocean.*ds,'all');
    oor_mean_lm(k,1)=sqrt(sum( temp.^2.*ds ,'all')/m);
end


ss.rms_oor=rms_oor;
ss.oor_mean=oor_mean;
ss.oor_rms_tws=oor_rms_tws;
ss.oor_rms_tws_low=oor_rms_tws_low;
ss.oor_mean_low=oor_mean_low;
ss.oor_mean_lm=oor_mean_lm;
end