function [h,yall]=show_slice(mysf,tt,slice_fir,slice_ceta,plot_flag)
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
% date: 2024-02-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
gfir=mysf.fir;
gceta=mysf.ceta;
load coast;

if length(slice_fir)~=length(slice_ceta)

    if length(slice_fir)==1
        fir=slice_fir*ones(1,length(slice_ceta));
        ceta=slice_ceta;
        flag=0;
    elseif length(slice_ceta)==1
        ceta=slice_ceta*ones(1,length(slice_fir));
        fir =slice_fir;
        flag=1;
    else
        error('');
    end
else
    flag=2;
    fir =slice_fir;
    ceta=slice_ceta;
end
npt=length(fir);

for k=1:npt
    dfir=abs(gfir-fir(k));
    dceta=abs(gceta-ceta(k));

    [~,ifir]=sort(dfir,'ascend');
    [~,iceta]=sort(dceta,'ascend');

    ifir=sort(ifir(1:2),'ascend');
    iceta=sort(iceta(1:2),'ascend');
    lf=ifir(1):1:ifir(2);
    lc=iceta(1):1:iceta(2);

    [X,Y]=meshgrid(gfir(lf),gceta(lc));
    %     load land_mask_csr.mat;

    temp=mysf.value(lc,lf,tt);
    Z=temp;
    temp = interp2(X,Y,Z,fir(k),ceta(k),'nearest');
    
    [in]=inpolygon(fir(k),ceta(k),long,lat);
%     in
    if in==1
        yland(k)=temp;
        yocean(k)=nan;
    else
        yland(k)=nan;
        yocean(k)=temp;
    end
    yall(k)=temp;
end

switch flag

    case 0

        h(1)=plot(slice_ceta,yall,'LineWidth',2);
%         hold on;
%         h(2)=plot(slice_ceta,yland,'Marker','o','LineWidth',2);
%         hold on;
%         h(3)=plot(slice_ceta,yocean,'Marker','+');
%         plot(slice_ceta,yall);
        xlabel('纬度（°）');
    case 1
        h(1)=plot(slice_fir,yall,'LineWidth',2);
%         hold on;
%         h(2)=plot(slice_fir,yland,'Marker','o','LineWidth',2);
%         hold on;
%         h(3)=plot(slice_fir,yocean,'Marker','+');
        xlabel('经度（°）');
    case 2
        sf=deg2rad(slice_fir-slice_fir(1));
        sc=deg2rad(slice_ceta-slice_ceta(1));
        sall=sqrt(sf.^2+sc.^2);
        sall=sall.*6371;

        if plot_flag==0
        h=plot(sall,yall);
            xlabel('公里');
        elseif plot_flag==1
            h=plot(yall,sall);
            ylabel('公里');
        end
end
end

