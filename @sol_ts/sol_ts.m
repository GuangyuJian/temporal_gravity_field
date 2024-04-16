classdef sol_ts<sol

    properties
        unit char  {mustBeMember(unit,{'none','ewh (mm)','uGal'})}='none';
        value (:,1) double
        name char
    end
    %%
    methods
        function self=sol_ts(value,unit)
            self=self@sol();
            self.value=value(:);
            self.unit=unit;
        end

        %% interp
        [self2]=filling(self,trange);
        %% plot
        [h]=ts_plot(self);
        [h]=ts_bar(self);
        [h]=tsa_fft(self,fs,trange,fillflag);
        [h]=tsa_xwt(obj1,obj2);
        [h]=tsa_wtc(obj1,obj2);
        [self]=mov_ts_plot(self,windows);
        %% math
        %         objnew = plus(objl,objr);
        %         objnew = minus(objl,objr)
        %         objnew = mean(obj1,ts,te);
        %         [self] = de_bg(self,ts,te);
        [self2]=ts_res(self) ;
        [obj2]=ts_mov(obj1,windows);
        
        %% statistic
        [r,p]=ts_corrcoef(solts1,solts2)
        %          [r,lags]=ts_xcor_12(obj1,obj2)
        [rlagsinfo,lagsinfo,rinfo]=ts_xcor_12(obj1,obj2)
        [obj2]=ts_nor(obj1);
        [mean_an]=mean_annual(self,trange,filling_flag);
        % temp
        [self]=seasonal_harmonic(self);
    end
end


