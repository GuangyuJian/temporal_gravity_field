%----------------------------------------------
function [gdc]=scf_gc2gdc(gc,maxn)

ae        =  6378136.3;
rho_w = 1000;       % density of water kg/m^3
rho_ave = 5517;     % average density of the earth kg/m^3
GM        =  3.986004415e14;    % [m^3 / s^2]



for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    en=st+n;
    factor(st:en,1)=(n+1)*GM/ae/ae*1e8; %ugal

end
gdc=factor(:).*gc(:);
end
