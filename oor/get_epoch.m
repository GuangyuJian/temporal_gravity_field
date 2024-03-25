function [llc,t1,t2]=get_epoch(soltime)
flag=0;
for y=2002:2022
        for m=1:12
            flag=flag+1;
            if m<10
            str1=[char(num2str(y)) '0' char(num2str(m)) '01'];
            str2=[char(num2str(y)) '0' char(num2str(m)) '30'];
            else
                
               str1=[char(num2str(y)) char(num2str(m)) '01'];
                str2=[char(num2str(y))  char(num2str(m)) '30'];  
            end
             time(flag)=yyyymmdd2t(str1)/2+yyyymmdd2t(str2)/2;
        end
end
t1=time(4:4+229-1);
flag=0;
t2=soltime(~isnan(soltime));
for t=1:length(t2)
   lc=find(t1==t2(t)|(abs(t1-t2(t))<1/24));
   disp(t);
   if ~isempty(lc)
       flag=flag+1;
        llc(flag)=lc;
        disp(lc);
   end
end

end