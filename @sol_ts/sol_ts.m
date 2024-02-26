classdef sol_ts<sol

    properties
        unit char
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
        [h]=ts_bar(self)                  
        [h]=tsa_fft(self,fs,trange,fillflag)    

        %% math        
%         objnew = plus(objl,objr);
%         objnew = minus(objl,objr)
%         objnew = mean(obj1,ts,te);
%         [self] = de_bg(self,ts,te);
        %% statistic
        [r,p]=ts_corrcoef(solts1,solts2)    
    end
end


