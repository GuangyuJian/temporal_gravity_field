function [sf_fm,rms_it]=fm_zf(mysf,myf,myb,ocean_mask,noise_level)
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
% date: 2024-02-02
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

land_mask=1-ocean_mask;

basin_mask=myb.mask;
fir=myb.fir;
ceta=myb.ceta;
unit=mysf.unit;

tempsf=sol_sf([],unit,fir,ceta);

ntime=size(mysf.value,3);
d=180/size(mysf.value,1);


rms_it=zeros(ntime,100);
for t=1:ntime
    model0=mysf.value(:,:,t);
    %     rms_dif=10000;
    model1=model0;

    %     nit=1;
    %     rms_it(t,nit)=rms_dif;
    t
    if length(noise_level)==1
        delta=noise_level;
    elseif length(noise_level)==ntime
        delta=noise_level(t);
    end
    for nit=1:20
        %     while rms_dif>delta&nit<=100
        %         nit=nit+1;
        myb.mask=land_mask;
        [ml,sl]=sol_sf.grid2ts(model1,myb);

        myb.mask=ocean_mask;
        [~,so]=sol_sf.grid2ts(model1,myb);

        mo=-ml*so/sl;

        model1=model1.*land_mask+mo.*ocean_mask;

        tempsf.value=model1;
        shctemp=tempsf.sf2shc(myf,myb,'mc');
        tempsf=shctemp.shc2sf(myf,myb,'mc');
        model2=tempsf.value;

        dif_obs=model0-model2;
% close all
% obs2map_fs12(dif_obs,[-300 300]/6,[-100 -70 5 25])
        myb.mask=basin_mask;
        [rms_dif]=sol_sf.grid2rms(dif_obs,myb);
        rms_it(t,nit)=rms_dif;

        if nit>1
            rms_dif
%             rms_dif2=abs(rms_it(t,nit)-rms_it(t,nit-1));
            if rms_dif<delta
                break
            end
        end
        model1=model1+dif_obs*1.4;
        %         rms_dif
    end
    output(:,:,t)=model1;

end
sf_fm=sol_sf(output,unit,fir,ceta);
end

