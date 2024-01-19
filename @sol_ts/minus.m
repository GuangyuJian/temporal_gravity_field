function objnew = minus(objl,objr)

vl=objl.value;

switch class(objr)
    case     'double'
        vr=objr;
        value=vl(:)-vr(:);
    case '@sol_ts'
        vr=objr.value;
        if length(vl)==length(vr)
            value=vl(:)-vr(:);
        else
            error();
        end
end

unit=objl.unit;
objnew=sol_ts(value,unit);
objnew.name=objl.name;
objnew.time=objl.time;
objnew.int_year=objl.int_year;
objnew.int_month=objl.int_month;
end