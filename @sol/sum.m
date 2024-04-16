function [objv2]=sum(objv,dim)

nsol=length(objv);


switch dim

    case 1

        switch class(objv)
            %%
            case 'sol_sf'
                for k=1:nsol
                    temp=objv(k).value;
                    fir=objv.fir;
                    ceta=objv.ceta;
                    tempm=sum(temp,3);
                    unit=objv.unit;
                    objv2(k)=sol_sf(tempm,unit,fir,ceta);
                end
                %%
            
            case 'sol_shc'
                for k=1:nsol
                    shct=objv(k).storage;

                    [sht]=storage_shct2sht(shct) ;
                    disp('!---')
                    shtm=sum(sht,2);
                    shcm=storage_sht2shct(shtm);
                    maxn=objv(k).maxn;
                    storage_type=objv(k).storage_type;
                    type=objv(k).type;
                    %
                    objv2(k)=sol_shc(shcm,maxn,storage_type,type);
                    objv2(k).shc_sigma=objv(k).shc_sigma;
                end
            case 'sol_ts'
                for k=1:nsol
                    temp=objv(k).value;
                    tempm=sum(temp);
                    unit=objv(k).unit;
                    objv2(k)=sol_ts(tempm,unit);
                end
            otherwise
                error('!');
        end

    case 2

        nsol=length(objv);
        objv2=objv(1)-objv(1);
        for k=1:nsol
            objv2=objv2+objv(k);
        end

    otherwise
        error('wrong argument:mean@sol');
end

end
% objv2=objv(1)-objv(1);
% if nargin==1
%
%     for k=1:length(objv)
%         objv2=objv2+objv(k);
%     end
%
% elseif nargin==2
%
%     for k=1:length(lc)
%         objv2=objv2+objv(lc(k));
%     end
%
% end