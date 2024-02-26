f=0;
for y1=2002:2024

    y2=y1+1;

    if ( mod(y1,4)==0 &&  mod(y1,400)~=0 ) || mod(y1,400)==0 % leap year
        d1=366;
    else
        d1=365;
    end

    f=f+1;
    [meanday(f),meantime(f),mean_year(f)]=gdut_get_mean_day(y1,y2,d1,1);
    meandis(f)=meantime(f)-y1;
end