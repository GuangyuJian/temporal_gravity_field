classdef sol<handle

    properties
        time
        int_year
        int_month
        info char
        harmonic
    end

    %%
    methods
        function self=sol()
            self.info=[];
        end

        function [self]=set_time(self,time,int_year,int_month)
            self.time=time;
            self.int_year=int_year;
            self.int_month=int_month;
        end
        []=show_info(self)
        [self]=append_info(self,info_type);
        [self2]=extra(self,varargin);
        [self]=get_harmonic(self,varargin);

        objnew=plus(objl,objr);
        objnew=minus(objl,objr);
        objnew = mean(obj1,ts,te);
        [self]=de_bg(self,ts,te);
    end

    methods(Static)
        %         [grid]= fit_harmonic_sf(t1,ewh);
        %         [grid]= fit_harmonic_sf_mask(t1,ewh)
        %         [varargout]=fit_harmonic_ts(t,tws,t2)
    end
end


