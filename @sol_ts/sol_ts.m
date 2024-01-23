classdef sol_ts<sol

    properties
        unit char
        value (:,1) double
        name char
        harmonic
%         time
%         int_year
%         int_month
    end
    %%
    methods
        function self=sol_ts(value,unit)
            self=self@sol();
            self.value=value(:);
            self.unit=unit;
        end


        ts_plot(self);
        % math
         []=show_info(self);
        [self]=append_info(self,info_type);
        
        objnew = plus(objl,objr);
        objnew = minus(objl,objr)

        [myts]=tf2harmonic(myts,trange);
    end
end


