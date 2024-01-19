function objnew = minus(objl,objr)

value=objl.value-objr.value;
fir=objl.fir;
ceta=objl.ceta;
unit=objl.unit;

objnew=sol_sf(value,unit,fir,ceta);
objnew.time=objl.time;
objnew.int_year=objl.int_year;
objnew.int_month=objl.int_month;
end
