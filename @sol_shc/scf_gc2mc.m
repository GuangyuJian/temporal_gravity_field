%----------------------------------------------
function [mc]=scf_gc2mc(gc,maxn)
% kn=math_Lovenum(maxn);

% L=[0,1,2,3,4,5,6,7,8,9,10,12,15,20,30,40,50,70,100,150,200];
% KL=[0,0.027,-0.303,-0.194,-0.132,-0.104,-0.089,-0.081,-0.076,-0.072,-0.069,-0.064,-0.058,-0.051,-0.040,-0.033,-0.027,-0.020,-0.014,-0.010,-0.017];
% l=0:1:Lmax;
% kl= interp1(L,KL,l,'linear') ;
% for l=0:Lmax
%     st=2+(l+2)*(l-1)/2;
%     en=st+l;
%      coe_love(st:en,1)=(2*l+1)/(kl(l+1)+1);
% end
% end


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
%     factor(st:en,1)=dens*kn(st:en,1);
end
mc=factor(:).*gc(:);
end
