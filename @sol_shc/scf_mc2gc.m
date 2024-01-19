
function [gc]=scf_mc2gc(mc,maxn)
% kn=math_Lovenum(maxn);
load('HanWahrLoveNumbers.mat');
ae        =  6378136.3;
rho_w = 1000;       % density of water kg/m^3
rho_ave = 5517;     % average density of the earth kg/m^3

dens = ae*rho_ave/(3);
k(2) = 0.021;

for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    en=st+n;
        factor(st:en,1)=dens*(2*n+1)/(k(n+1)+1);
%     factor(st:en,1)=(1/kn(t:en,1))/dens;
end
gc=mc(:)./factor(:);

end