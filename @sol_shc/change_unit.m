function [self]=change_unit(self,unit_want)
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

unit_original=self.unit;
if strcmp(unit_want,unit_original)
    disp('no need for transforming');
    disp(['original ones is' unit_want]);
else
    self.unit=unit_want;

    temp=[unit_original '2' unit_want];
    in_shc=self.storage;

    switch temp

        case 'gc2mc'
            for k=1:length(in_shc)
                [ou_shc(k).cnm]=gc2mc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=gc2mc(in_shc(k).snm,maxn);
            end
        case 'mc2gc'
            for k=1:length(in_shc)
                [ou_shc(k).cnm]=mc2gc(in_shc(k).cnm,maxn);
                [ou_shc(k).snm]=mc2gc(in_shc(k).snm,maxn);

            end
    end
    self.storage=ou_shc;

end


end

%----------------------------------------------
function [mc]=gc2mc(gc,maxn)
kn=math_Lovenum(maxn);
ae        =  6378136.3;
rho_w = 1000;       % density of water kg/m^3
rho_ave = 5517;     % average density of the earth kg/m^3

dens = ae*rho_ave/(3.*rho_w);
% kn(2) = 0.021;

for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    en=st+n;
%     factor(st:en,1)=dens*(2*n+1)/(kn(n+1)+1);
    factor(st:en,1)=dens*kn(n+1);
end
mc=factor(:).*gc(:);
end

function [mc]=mc2gc(gc,maxn)
kn=math_Lovenum(maxn);
ae        =  6378136.3;
rho_w = 1000;       % density of water kg/m^3
rho_ave = 5517;     % average density of the earth kg/m^3

dens = ae*rho_ave/(3.*rho_w);
% kn(2) = 0.021;

for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    en=st+n;
    factor(st:en,1)=1/kn(n+1)/dens;
end
mc=factor(:).*gc(:);

end



