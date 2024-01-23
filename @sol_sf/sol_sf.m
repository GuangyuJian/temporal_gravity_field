classdef sol_sf<sol

    properties
        unit char  {mustBeMember(unit,{'none','ewh (mm)','ugal'})}='none';
        fir double
        ceta double
        value double
        show_range
        harmonic
%         time
%         int_year
%         int_month
%         info
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

        self=plot_degree_amplitude(self);
        self=imagesc_tt(self,tt);
        self=imagesc_region(self,tt);
        self=imagesc_shc_amplitude(self);
        obs2map_tt(self,varargin);
        harmonic2map(self,varargin)

        objnew = plus(objl,objr);
        objnew = minus(objl,objr);
        % math
        [myts]=sf2ts(sol_sf,study_basin);
        [my_shc]=sf2shc(sol_sf,sol_filter,study_basin,type);
        []=show_info(self);
        [self]=append_info(self,info_type);
        
        [mysf]=sf2harmonic(mysf,trange,mask);
    end

    methods(Static)
        
        [tws1,S]=grid2ts(grid,study_basin);
    end
end


