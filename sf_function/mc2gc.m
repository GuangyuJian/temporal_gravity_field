
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