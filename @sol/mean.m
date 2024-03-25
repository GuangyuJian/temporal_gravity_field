function objnew = mean(obj1,ts,te)



switch class(obj1)
    %%
    case 'sol_sf'
        temp=obj1.value;
        time=obj1.time;

        loc=find(time>ts&time<te);
        tempm=mean(temp(:,:,loc),3);
        objnew=sol_sf(tempm,obj1.unit,obj1.fir,obj1.ceta);

        %%
    case 'sol_shc'

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
                objnew.shc_sigma=obj1.shc_sigma;
    case 'sol_ts'

        temp=obj1.value;
        time=obj1.time;

        loc=find(time>ts&time<te);
        tempm=mean(temp(loc));

        unit=obj1.unit;
        objnew=sol_ts(tempm,unit);


    otherwise

end

% objnew.set_time(obj1.time,obj1.int_year,obj1.int_month);

end