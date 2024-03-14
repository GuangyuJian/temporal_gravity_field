function objnew=minus(objl,objr)



switch class(objl)
    %%
    case 'sol_sf'
        value=objl.value-objr.value;
        fir=objl.fir;
        ceta=objl.ceta;
        unit=objl.unit;
        objnew=sol_sf(value,unit,fir,ceta);
        %%
    case 'sol_shc'

        if strcmp(objl.type,objr.type)
        else
            show_time_tag;
            disp('sol_shc:-->plus: different tyep');
            objr.change_type(objl.type);
        end

        if objl.maxn~= objr.maxn
            error('different max degree');
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
    case 'sol_ts'
        vl=objl.value;
        switch class(objr)
            case     'double'
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

        end

      
end
  objnew.set_time(objl.time,objl.int_year,objl.int_month);

end