classdef sol_shc<sol

    properties
        type                char  {mustBeMember(type,{'gc','mc','gdc'})}='gc';
        unit                char  {mustBeMember(unit,{'none','ewh (mm)','uGal'})}='none';
        storage_type(1,:)   char {mustBeMember(storage_type,{'shc'})}='shc';

        maxn        (1,1)   double
        storage             struct
        shc_sigma           struct
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
                %shc(tt).cnm_sigma=shc(tt).cnm_sigma(1:en);
                %shc(tt).snm_sigma=shc(tt).snm_sigma(1:en);
            end
            self.storage=shc;
            self.maxn=maxn;
            self.storage_type=storage_type;
            self.type=type;
            switch type
                case 'gc'
                    self.unit='none';
                case 'gdc'
                    self.unit='uGal';
                case 'mc'
                    self.unit='ewh (mm)';
            end
            self.info=[];
        end
     
        %% show-----------------------------------------
        % power spectrum
        [h,sc_degre ]=show_sps_perm(self,tt) 
        [h,sc_degre ]=show_sps_pern(self,tt) ;
        [h,sc_degre]=show_sps(self,tt);
        [h,sc_degre]=show_nps(self,tt);

        % show spherical harmonic spectrum
        h=show_shc(self,tt);
        h=show_shc_sigma(self,tt);
        [h,csnm]=show_shct(self,n,m,type);

        % show  spectrum for a given spherical harmonic order
        [h]=show_nss(self,tt,mm,type);
        [h]=show_shc_ref(obj1,obj2)
        %% transfer
        [mysf]=shc2sf(myshc,myf,myb,type);
        [myvsf]=vshc2sf(myvshc,myf,myb,type);
        self=change_type(self,unit);

        %info
        %% math
%         objnew = plus(objl,objr);
%         objnew = minus(objl,objr);
%         objnew = mean(obj1,ts,te);
        [obj2]=truncate(obj1,maxnnew);
        [obj2]=truncate_m(obj1,maxm)    
        [obj2]=truncate_m1_m2(obj1,maxm)          
%         objnew = mtimes(objl,objr);
%         objnew = mrdivide(objl,objr);
%       [self] = de_bg(self,ts,te);
    end

    methods(Static)
        [gc] =scf_mc2gc(mc,maxn);
        [gc] =scf_gdc2gc(gdc,maxn) ;
        [mc] =scf_gc2mc(gc,maxn);
        [gdc]=scf_gc2gdc(gc,maxn);
    end

end


