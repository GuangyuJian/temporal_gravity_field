classdef sol_shc<handle

    properties
        type char  {mustBeMember(type,{'gc','mc'})}='gc';
        unit  char  {mustBeMember(unit,{'none','ewh (m)'})}='none';
        storage_type(1,:) char {mustBeMember(storage_type,{'vec','cs','shc','clm','sc','sh'})}='shc';
        maxn double
        storage struct
        time
        int_year
        int_month
        info char
    end

    %%
    methods
        function self=sol_shc(storage,maxn,storage_type,type)

            shc=storage;
            [en]=get_en(maxn);
            for tt=1:length(shc)
                shc(tt).cnm=shc(tt).cnm(1:en);
                shc(tt).snm=shc(tt).snm(1:en);
            end
            self.storage=shc;
            self.maxn=maxn;
            self.storage_type=storage_type;
            self.type=type;
            switch type

                case 'gc'

                    self.unit='none';

                case 'mc'
                    self.unit='ewh (m)';
            end

            self.info=[];
        end

        self=change_type(self,unit)
        self=change_storage(self,storage_type)
         [self]=de_bg(self,ts,te);
        show_info(self);
        [self]=append_info(self,info_type);
    
        % math
        objnew = plus(objl,objr);
        objnew = minus(objl,objr)
        objnew = mean(obj1,ts,te)

    end
end


