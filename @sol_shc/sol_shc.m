classdef sol_shc<sol

    properties
        type char  {mustBeMember(type,{'gc','mc','gdc'})}='gc';
        unit  char  {mustBeMember(unit,{'none','ewh (mm)','ugal'})}='none';
        storage_type(1,:) char {mustBeMember(storage_type,{'shc'})}='shc';

        maxn double
        storage struct
        shc_sigma  struct
%         time
%         int_year
%         int_month
%         info char
    end

    %%
    methods
        function self=sol_shc(storage,maxn,storage_type,type)
            self=self@sol();
            shc=storage;
            [en]=get_en(maxn);
            for tt=1:length(shc)
                shc(tt).cnm=shc(tt).cnm(1:en);
                shc(tt).snm=shc(tt).snm(1:en);
                %                 shc(tt).cnm_sigma=shc(tt).cnm_sigma(1:en);
                %                 shc(tt).snm_sigma=shc(tt).snm_sigma(1:en);
            end
            self.storage=shc;
            self.maxn=maxn;
            self.storage_type=storage_type;
            self.type=type;
            switch type
                case 'gc'
                    self.unit='none';
                case 'gdc'
                    self.unit='ugal';
                case 'mc'
                    self.unit='ewh (mm)';
            end
            self.info=[];
        end
        self=change_type(self,unit);
        [self]=de_bg(self,ts,te);
        % show
        show_info(self);
        h=show_shc(self,tt);
        h=show_shc_sigma(self,tt);
        [h]=show_shc_degree_sigma(self,tt);
        [h]=show_shc_degree(self,tt);
        [h]=show_nss(self,tt,mm,type)
%%
        [sf]=shc2sf(sol_shc,sol_filter,study_basin,type);
        %info
        [self]=append_info(self,info_type);
        % math
        objnew = plus(objl,objr);
        objnew = minus(objl,objr);
        objnew = mean(obj1,ts,te);
    end

    methods(Static)
        [gc]=scf_mc2gc(mc,maxn);
        [gc]=scf_gdc2gc(gdc) ;
        [mc]=scf_gc2mc(gc,maxn);
        [gdc]=scf_gc2gdc(gc,maxn);
    end

end


