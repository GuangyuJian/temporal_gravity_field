classdef sol_sf<sol

    properties
        unit char  {mustBeMember(unit,{'none','ewh (mm)','ugal'})}='none';
        fir double
        ceta double
        value double
        show_range
    end
    %%
    methods
        function self=sol_sf(value,unit,fir,ceta)
            self=self@sol();
            self.value=value;
            self.unit=unit;
            self.fir=fir;
            self.ceta=ceta;
            self.info=[];
        end

%         self=plot_degree_amplitude(self);
%         self=imagesc_tt(self,tt);
        %% plot
        [h]=imagesc_tt(self,varargin);
        []=obs2map_tt(self,varargin);
        [h]=harmonic2map(self,varargin)
        [h,y1]=show_slice(self,tt,slice_fir,slice_ceta,plot_flag);
        %% math        
%         objnew = plus(objl,objr);
%         objnew = minus(objl,objr);
%         objnew = mean(objl,ts,te);
%         [self]=de_bg(self,ts,te);
        %% math2
        [sigma_n]=mean_geoid_height(self,maxn);
        [tso,tsl]=check_mass_conservation(mysf,ocean_mask);
        %% transfer
        [ts]=get_point_ts(self,fir,ceta)
        [myts]  =sf2ts(sol_sf,study_basin);
        [my_shc]=sf2shc(sol_sf,sol_filter,study_basin,type);
         [my_shc]=sf2gc_maxn(mysf,maxn)
         [myts]=vsf2ts(mysf)    ;
    end

    methods(Static)
        [tws1,S]=grid2rms(grid,study_basin);
        [tws1,S]=grid2ts(grid,study_basin);
    end
end


