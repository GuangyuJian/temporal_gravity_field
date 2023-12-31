classdef sol_shc<handle

    properties
        unit char  {mustBeMember(unit,{'gc','mc'})}='gc';
        storage_type(1,:) char {mustBeMember(storage_type,{'vec','cs','shct','shc','clm','sc','sh'})}='shc'; 
        maxn double
        storage struct
        ymd

    end

    %%
    methods
        function self=sol_shc(storage,maxn,storage_type,unit)
            self.storage=storage;
            self.maxn=maxn;
            self.storage_type=storage_type;
            self.unit=unit;
        end

        self=change_unit(self,unit)
        
    

        
    end
end


