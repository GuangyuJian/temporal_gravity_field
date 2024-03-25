function objnew = mtimes(objl,objr)

switch class(objl)

    case 'sol_shc'
        shctemp=objl;
        sc=objr;
    case 'double'
        shctemp=objr;
        sc=objl;
    otherwise
        error('!');
end
if ~strcmp(class(sc),'double')
    error('!');
end

if strcmp(class(objl),class(objr))
    error('!');
end

shc=shctemp.storage;
for tt=1:length(shc)
    shc(tt).cnm=shc(tt).cnm*sc;
    shc(tt).snm=shc(tt).snm*sc;
end

% storage=shc;
maxn=shctemp.maxn;
storage_type=shctemp.storage_type;
type=shctemp.type;

objnew=sol_shc(shc,maxn,storage_type,type);
objnew.time=shctemp.time;
objnew.int_year=shctemp.int_year;
objnew.int_month=shctemp.int_month;
objnew.shc_sigma=shctemp.shc_sigma;
end