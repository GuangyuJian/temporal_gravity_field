function [myts]=get_point_ts(mysf,fir,ceta)
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
for j=1:length(mysf)
    tempsf=mysf(j);
    gfir=tempsf.fir;
    gceta=tempsf.ceta;

    dfir=abs(gfir-fir);
    dceta=abs(gceta-ceta);

    [~,ifir]=sort(dfir,'ascend');
    [~,iceta]=sort(dceta,'ascend');

    ifir=sort(ifir(1:2),'ascend');
    iceta=sort(iceta(1:2),'ascend');
    lf=ifir(1):1:ifir(2);
    lc=iceta(1):1:iceta(2);
    ntime=size(tempsf.value,3);
    [X,Y]=meshgrid(gfir(lf),gceta(lc));
    load land_mask_csr.mat;

    % X=X(:);
    % Y=Y(:);
    clear y1;
    for k=1:ntime
        temp=tempsf.value(lc,lf,k);
        Z=temp;
        y1(k) = interp2(X,Y,Z,fir,ceta,'linear');
    end
    % ts=y1;
    myts(j)=sol_ts(y1,'ewh (mm)');
    myts(j).set_time(tempsf.time,tempsf.int_year,tempsf.int_month);
end
end
