classdef sol<handle

    % This is a superclass. 
    % It has three subclasses: sol_shc, sol_sf, and sol_ts.
    % The linear operations including: 
    % + - x / of the three subclasses
    % are defined in this parent class.



    properties
        time double
        int_year double
        int_month double
        info char
        harmonic double
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
        %% show
        []=show_info(self)
        [self]=append_info(self,info_type);
        %%
        [self2]=extra(self,varargin);
        [self]=get_harmonic(self,varargin);
        %% math
        objnew= plus    (objl,objr);
        objnew= minus   (objl,objr);
        objnew= mtimes  (objl,objr);
        objnew= mrdivide(objl,objr);
        objnew= mean    (obj1,ts,te);
        [self]= de_bg(self,ts,te);
        [objv2]=sum(objv,lc);
    end

    methods(Static)
        %         [grid]= fit_harmonic_sf(t1,ewh);
        %         [grid]= fit_harmonic_sf_mask(t1,ewh)
        %         [varargout]=fit_harmonic_ts(t,tws,t2)
    end
end


