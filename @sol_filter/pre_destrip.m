function [self]=pre_destrip(self,destrip_flag,PnMl_n,PnMl_m)

if destrip_flag==1
    self.destrip_flag=1;
    if PnMl_n>=3&&PnMl_n<7
        self.PnMl_n=PnMl_n;
    else
        error('wrong');
    end
    self.PnMl_m=PnMl_m;
else
    self.destrip_flag=0;
end
show_time_tag;
disp('sol_filter:——>pre_destrip: done');
end