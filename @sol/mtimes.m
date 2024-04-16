function objnew=mtimes(objl,objr)



switch class(objl)
    %
    case 'sol_shc'
        vl=objl.value;
        switch class(objr)
            case     'double'
                vr=objr;
                value=vl*vr(:);
                unit=objl.unit;
                objnew=sol_shc(value,objl.unit,objl.fir,objl.ceta);

        end

    case 'sol_sf'
        vl=objl.value;
        switch class(objr)
            case  'double'
                vr=objr;
                value=vl*vr(:);
                unit=objl.unit;
                objnew=sol_sf(value,objl.unit,objl.fir,objl.ceta);

        end

    case 'sol_ts'
        vl=objl.value;
        switch class(objr)
            case     'double'
                vr=objr;
                value=vl(:)*vr(:);
                unit=objl.unit;
                objnew=sol_ts(value,unit);
                objnew.name=objl.name;
        end
end

objnew.set_time(objl.time,objl.int_year,objl.int_month);

end