function [self]=pre_destrip(self,PnMl_flag,PnMl_n,PnMl_m)

if PnMl_flag==1
    self.PnMl_flag=1;
    if PnMl_n>=3&&PnMl_n<7
        self.PnMl_n=PnMl_n;
    else
        error('wrong');
    end
    self.DD_start_order=PnMl_m;
else
    self.PnMl_flag=0;
end

end