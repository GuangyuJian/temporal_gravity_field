function objnew=minus(objl,objr)
% objnew=objl-objr
% usage:
% objnew=objl（1）-objr（1）
% objnew=objl（1）-【objl（1）objl（2）】
% objnew=【objl（1）objl（2）】-objl（1）
% objnew=【objl（1）objl（2）】-【objl（1）objl（2）】
% 【objl（1）objl（2）】is vector of object
% 
% overload the operator of minus: '-'
%----------------------------------------------------------------------------
% In   :    objl    [1xn] @sol or double
%           objr    [1xn] @sol or double
% Out  :
%           objnew  [1xn] @sol
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

if length(objl)==1&length(objr)==1

    if isa(objl,'double')
        temp=-objl;
        objr.value=objr.value*(-1);
        objl=objr;
        objr=temp;
        clear temp
    end

    switch class(objl)
        %%
        case 'sol_sf'
            switch class(objr)

                case 'sol_sf'

                    value=objl.value-objr.value;
                    fir=objl.fir;
                    ceta=objl.ceta;
                    unit=objl.unit;
                    objnew=sol_sf(value,unit,fir,ceta);

%                 case 'double'
%                     value=objl.value-objr;
%                     fir=objl.fir;
%                     ceta=objl.ceta;
%                     unit=objl.unit;
%                     objnew=sol_sf(value,unit,fir,ceta);
            end
            %%
        case 'sol_shc'

            if strcmp(objl.type,objr.type)
            else
                show_time_tag;
                disp('minus@sol: different tyep');
                objr.change_type(objl.type);
            end

            if objl.maxn~= objr.maxn
                error('minus@sol:different max degree');
            end
            shcr=objr.storage;
            shcl=objl.storage;


            if length(shcr)==1
                for tt=1:length(shcl)
                    shcl(tt).cnm=shcl(tt).cnm-shcr.cnm;
                    shcl(tt).snm=shcl(tt).snm-shcr.snm;
                end
            elseif length(shcr)>1
                for tt=1:length(shcl)
                    shcl(tt).cnm=shcl(tt).cnm-shcr(tt).cnm;
                    shcl(tt).snm=shcl(tt).snm-shcr(tt).snm;
                end
            end

            storage=shcl;
            maxn=objl.maxn;
            storage_type=objl.storage_type;
            type=objl.type;

            objnew=sol_shc(storage,maxn,storage_type,type);
            objnew.shc_sigma=objl.shc_sigma;
            %%
        case 'sol_ts'
            vl=objl.value;
            switch class(objr)
                case  'double'
                    vr=objr;
                    value=vl(:)-vr(:);
                    unit=objl.unit;
                    objnew=sol_ts(value,unit);
                    objnew.name=objl.name;

                case 'sol_ts'
                    vr=objr.value;
                    if length(vl)==length(vr)
                        value=vl(:)-vr(:);
                    else
                        if length(vl)==1||length(vr)==1
                            value=vl(:)-vr(:);
                        else
                            error('!');
                        end
                    end

                    unit=objl.unit;
                    objnew=sol_ts(value,unit);
                    objnew.name=objl.name;
                otherwise
                    error('!');
            end

    end
    objnew.set_time(objl.time,objl.int_year,objl.int_month);
else
    if length(objr)==1
        for k=1:length(objl)
            objnew(k)=objl(k)-objr;
        end
    elseif length(objl)==length(objr)

        for k=1:length(objl)
            objnew(k)=objl(k)-objr(k);
        end
    elseif length(objl)==1

        for k=1:length(objr)
            objnew(k)=objl-objr(k);
        end
    end
end


end