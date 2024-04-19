classdef sol<handle

    % This is a superclass. 
    % It has three subclasses: sol_shc, sol_sf, and sol_ts.
    % The linear operations including: 
    % + - x / of the three subclasses
    % are defined in this parent class.
    % sum   
    % mean
    %     
    properties
        time double
        int_year double
        int_month double
        %----------------- for sysu-module
        int_day double      %modify by kj 20240415
        span double         % modify by kj 20240415
        %------------------
        info char
        harmonic double
    end

    %%
    methods
        function self=sol()
            self.info=[];
        end
        [self]=set_time(self,time,int_year,int_month);
        %% show
        []=show_info(self);
        [self]=append_info(self,info_type);
        %%
        [self2]=extra(self,varargin);
        [self]=get_harmonic(self,varargin);
        %% check
         [ym_char,ym_flag]=check_ym(self,tt)
        %% math
        objnew  = plus      (objl,objr); 
        objnew  = minus     (objl,objr);
        objnew  = mtimes    (objl,objr);
        objnew  = mrdivide  (objl,objr);
        objnew  = mean      (objv,dim); 
        objnew  = sum       (objv,dim);
        [self]  = de_bg     (self,ts,te);
    
%         [objv2]=sum(objv,lc);
%         objnew= mean(obj1,ts,te); %modify by kj 20240415
    end

    methods(Static)
        %         [grid]= fit_harmonic_sf(t1,ewh);
        %         [grid]= fit_harmonic_sf_mask(t1,ewh)
        %         [varargout]=fit_harmonic_ts(t,tws,t2)
    end
end


