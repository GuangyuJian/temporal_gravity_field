function [sf_fm,rms_it]=fm_zh_delta(mysf,myf,myb,ocean_mask,noise_level,delta_dif)
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
nit_max=100;

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
        rms_dif=10000;
    model1=model0*1.4;
    nit=0;

    t
    if length(noise_level)==1
        delta=noise_level;
    elseif length(noise_level)==ntime
        delta=noise_level(t);
    end
%     for nit=1:100
        while rms_dif>delta&nit<=nit_max
            nit=nit+1;
            %分配
            [model1]=reset_model(model1,land_mask,ocean_mask,myb);
            % 模拟
            [model2]=leakage_sim(model1,tempsf,myf,myb);

            dif_obs=model0-model2;
            myb.mask=basin_mask;
           
            [rms_dif]=abs(sol_sf.grid2ts(dif_obs,myb));
            [rms_dif]=sol_sf.grid2rms(dif_obs,myb);
            rms_it(t,nit)=rms_dif;

            if nit>1
                rms_dif
                rms_dif2=abs(rms_it(t,nit)-rms_it(t,nit-1));
                if rms_dif<delta||rms_dif2<delta_dif
                    break
                end
            end

            model1=model1+dif_obs*0.7;
            %         rms_dif
        end
        output(:,:,t)=model1;

    end
    sf_fm=sol_sf(output,unit,fir,ceta);
    sf_fm.set_time(mysf.time,mysf.int_year,mysf.int_month);
end



    function [model2]=leakage_sim(model1,tempsf,myf,myb)
        tempsf.value=model1;
        shctemp=tempsf.sf2shc(myf,myb,'mc');
        tempsf=shctemp.shc2sf(myf,myb,'mc');
        model2=tempsf.value;
    end