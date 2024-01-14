function objnew = plus(objl,objr)

if strcmp(objl.type,objr.type)
else
    show_time_tag;
    disp('sol_shc:-->minus: different tyep');
objr.change_type(objl.type);
end

if objl.maxn~= objr.maxn
error('different max degree');
end
shcr=objr.storage;
shcl=objl.storage;

if length(shcr)==1
    for tt=1:length(shcl)
        shcl(tt).cnm=shcl(tt).cnm+shcr.cnm;
        shcl(tt).snm=shcl(tt).snm+shcr.snm;
    end
elseif length(shcr)>1
    for tt=1:length(shcl)
        shcl(tt).cnm=shcl(tt).cnm+shcr(tt).cnm;
        shcl(tt).snm=shcl(tt).snm+shcr(tt).snm;
    end
end

storage=shcl;
maxn=objl.maxn;
storage_type=objl.storage_type;
type=objl.type;

objnew=sol_shc(storage,maxn,storage_type,type);
objnew.time=objl.time;
objnew.int_year=objl.int_year;
objnew.int_month=objl.int_month;
end