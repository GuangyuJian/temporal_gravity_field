function [self]=change_type(self,type_want)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-30
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************
maxn=self.maxn;

type_original=self.type;
if strcmp(type_want,type_original)
%     disp('--------------------------')
%     disp('change_type: no need for transforming');
%     disp(['change_type: original ones is ' type_want]);
else
    self.type=type_want;

    temp=[type_original '2' type_want];
    in_shc=self.storage;

    switch temp

        case 'gc2mc'
            self.unit='ewh (mm)';
            for k=1:length(in_shc)
                [ou_shc(k).cnm]=sol_shc.scf_gc2mc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=sol_shc.scf_gc2mc(in_shc(k).snm,maxn);
            end

        case 'gc2gdc'
            self.unit='uGal';
            for k=1:length(in_shc)
                [ou_shc(k).cnm]=sol_shc.scf_gc2gdc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=sol_shc.scf_gc2gdc(in_shc(k).snm,maxn);
            end

        case 'mc2gc'
            self.unit='none';
            for k=1:length(in_shc)
                [ou_shc(k).cnm]=sol_shc.scf_mc2gc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=sol_shc.scf_mc2gc(in_shc(k).snm,maxn);
            end
        case 'mc2gdc'
            self.unit='uGal';
            for k=1:length(in_shc)
                [in_shc(k).cnm]=sol_shc.scf_mc2gc(in_shc(k).cnm,maxn);
                [in_shc(k).snm]=sol_shc.scf_mc2gc(in_shc(k).snm,maxn);
                [ou_shc(k).cnm]=sol_shc.scf_gc2gdc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=sol_shc.scf_gc2gdc(in_shc(k).snm,maxn);
            end

        case 'gdc2mc'
            self.unit='ewh (mm)';
            for k=1:length(in_shc)
                [in_shc(k).cnm]=sol_shc.scf_gdc2gc(in_shc(k).cnm,maxn);
                [in_shc(k).snm]=sol_shc.scf_gdc2gc(in_shc(k).snm,maxn);
                [ou_shc(k).cnm]=sol_shc.scf_gc2mc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=sol_shc.scf_gc2mc(in_shc(k).snm,maxn);
            end
        case 'gdc2gc'
            self.unit='none';
            for k=1:length(in_shc)
                [ou_shc(k).cnm]=sol_shc.scf_gdc2gc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=sol_shc.scf_gdc2gc(in_shc(k).snm,maxn);
            end
    end
    self.storage=ou_shc;

end


end
