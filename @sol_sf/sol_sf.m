classdef sol_sf

    properties
        unit char  {mustBeMember(unit,{'none','ewh (mm)','ugal'})}='none';
        fir double
        ceta double
        value double
        show_range

        time
        int_year
        int_month
    end
    %%
    methods
        function obj=sol_sf(value,unit,fir,ceta)
            obj.value=value;
            obj.unit=unit;
            obj.fir=fir;
            obj.ceta=ceta;
        end
        %          [self]=shc2sf(sol_tgf,sol_shc,type);
        self=plot_degree_amplitude(self);
        self=imagesc_tt(self,tt);
        self=imagesc_region(self,tt);
        self=imagesc_shc_amplitude(self);
        obs2map_tt(self,varargin)
        objnew = plus(objl,objr);
        objnew = minus(objl,objr);
        % math
        [myts]=sf2ts(sol_sf,study_basin);
        [my_shc]=sf2shc(sol_sf,sol_filter,study_basin,type);
        []=show_info(self);
        [self]=append_info(self,info_type);
    end
    methods(Static)
        [tws1,S]=grid2ts(grid,study_basin);
        %         [tws1,S]=grid2ts(grid,study_basin)
    end
end


