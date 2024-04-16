classdef sol_sf<sol

    properties
        unit char  {mustBeMember(unit,{'none','ewh (mm)','uGal'})}='none';
        fir double
        ceta double
        value double
        show_range  % 
                    %  ——the first option
                    %   sol_sf.show_range=mat [1x4];
                    % mat=[mimimum_longitude maximum_longitude mimimum_latitude maximum_latitude ] 
                    %       unit:degree
                    %       longitude range from -180° to 180°
                    %       latitude range from -90° to 90°
                    %
                    %  ——the second option    
                    % sol_sf.show_range='global' means the whole sphere
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

%         self=plot_degree_amplitude(self); delete
%         self=imagesc_tt(self,tt); modify
        %% plot
        [h]=imagesc_tt(self,varargin);
        [ ]=obs2map_tt(self,varargin);
        [ ]=obs2map_Robinson_fs(ewh,value,range,titlename,fs);
        [h]=harmonic2map(self,varargin)
        [h,y1]=show_slice(self,tt,slice_fir,slice_ceta,plot_flag);
        %% math        
%         objnew = plus(objl,objr);
%         objnew = minus(objl,objr);
%         objnew = mean(objl,ts,te);
%         [self]=de_bg(self,ts,te);
        [mean_sf]=mean_annual_sf(mysf,ts,te)   ;
        %% math2
        [sigma_n]=mean_geoid_height(self,maxn);
        [tso,tsl]=check_mass_conservation(mysf,ocean_mask);
        %% transfer
        [ts]    =get_point_ts(mysf,fir,ceta);
        [myts]  =sf2ts(mysf,myb);
        [my_shc]=sf2shc(mysf,myf,myb,type);
        [my_shc]=sf2gc_maxn(mysf,maxn)
        [myts]  =vsf2ts(mysf);
    end

    methods(Static)
        [tws1,S]=grid2rms(grid,myb);
        [tws1,S]=grid2ts(grid,myb);
    end
end


