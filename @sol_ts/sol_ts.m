classdef sol_ts<handle

    properties
        unit char
        value (:,1) double
        name char

        time
        int_year
        int_month
    end
    %%
    methods
        function self=sol_ts(value,unit)
            self.value=value(:);
            self.unit=unit;

        end


        ts_plot(self);
        % math

        objnew = plus(objl,objr);
        objnew = minus(objl,objr)


    end
end


