classdef sol_sf<handle

    properties
        unit char
        fir double 
        ceta double
        value double
    end
    %%
    methods
        function self=sol_sf(value,unit,fir,ceta)
            self.value=value;
            self.unit=unit;
            self.fir=fir;
            self.ceta=ceta;
        end

        self=plot_degree_amplitude(self);
        self=imagesc_tt(self,tt);
        self=imagesc_basin(self,tt,study_basin);
        self=imagesc_shc_amplitude(self);
        
    end
end


