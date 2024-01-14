function objnew = mean(obj1,ts,te)


shct=obj1.storage;
time=obj1.time;


 [sht]=storage_shct2sht(shct) ;
 
loc=find(time>ts&time<te);
 shtm=mean(sht(:,loc),2);
 
 loc1=length(sht)/2;
 shcm.cnm=shtm(1:loc1);
 shcm.snm=shtm(1+loc1:end);
 

maxn=obj1.maxn;
storage_type=obj1.storage_type;
type=obj1.type;
% 
objnew=sol_shc(shcm,maxn,storage_type,type);
% objnew.time=objl.time;
% objnew.int_year=objl.int_year;
% objnew.int_month=objl.int_month;
end