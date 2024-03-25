function [pnm,cmf,smf,ds]=get_sob(myf,myb)
% [pnm,cmf,smf,ds]=get_sob(myf,myb)
% this function get the Spherical orthogonal basis (SOB) for 
% using Spherical harmonic synthesis (SHS)
%----------------------------------------------------------------------------
% In   :    myf [1x1]   @sol_filter    
%           myb [1x1]   @study_basin
% Out  :
%           pnm [en x rr] storages normolized associated legendred function
%                each column vector p(a_i) storages in degree-dependent format
%                the p(a_i) sorts by ceta along 2nd dimesion 
%           e.g.    
%               [poo(a1) poo(a2) poo(a3) 
%               p10(a1) p1o(a2) p1o(a3)
%               p11(a1) p11(a2) p11(a3)]
% 
%           cmf/smf [maxn x cc] cos/sin basis
%           ds  [rrx1] size of grid point in different latitudes over a sphere (radius=1) 
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-27
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

maxn=myf.maxn;
ceta=myb.ceta;
fir =myb.fir;

x=cosd(90-ceta);

pnm=math_NormLegendre(maxn,x);%完全规格化连带勒让德系数

mm=0:maxn;
smf=sind(fir(:)*mm)';
cmf=cosd(fir(:)*mm)';

N=length(ceta);
delta= 360/N;
d=deg2rad(delta);

f=0;
for c=90-ceta
    f=f+1;
    sum1=0;
    for k=0:N/2-1
        sum1=sum1+sind((2*k+1)*c)/(2*k+1);
    end
    ds(1,f)=4*pi/(N^2)*sind(c)*sum1;
end

% ds=ds;
end

function[Coe_P]=math_NormLegendre(Lmax,x)
%==============================================
%Input
%     Lmax : [1 x 1]      maxnimum of degree
%     x    : [1 x rr]     cos(latitude)
%Ouput
%     Coe_P: [en x rr]
%           coefficient of associated normalized
%           legendre function
%===============================================
% reference:
% help legendre in command line
% and
% https://agupubs.onlinelibrary.wiley.com
% /doi/full/10.1029/2018GC007529 Table1
% Wieczorek, Mark A., and Matthias Meschede. 2018. 
% ‘SHTools: Tools for Working with Spherical Harmonics’. 
% Geochemistry, Geophysics, Geosystems 19(8): 2574–92. 
% doi:10.1029/2018GC007529.

k=length(x);
x=x(:)'; %modified by KJ 20240219
% if size(x,1)~=1
%    x=x'; 
% end
% if Lmax>200
%     h=waitbar(0,'正在加载勒让德函数');
% end
for l=0:Lmax
    p=legendre(l,x,'norm');%归一化连带勒让德系数
    st=2+(l+2)*(l-1)/2;
    en=st+l;
    % Orthonormalized;
    %     Kronecker delta function（kdf）
    % Ylm (\omega) Yl'm'(\omega)=    kdf(ll')*kdf(mm');
    if l==0
        sc(1,1:k)=sqrt(2);
    else
        sc(1,1:k)=sqrt(2);
        sc(2:l+1,1:k)=2;
    end
    Coe_P(st:en,:)=p.*sc;
%     plm(l+1,1:l+1)=p.*m;
%     if Lmax>200
%         waitbar((l+1)/(Lmax+1),h);
%     end
    
end
end

% modify 20240111 K.J
% mvec=zeros(2+(maxn+2)*(maxn-1)/2,1);
% for n=0:maxn
%     st=2+(n+2)*(n-1)/2;
%     for m=0:n
%         mvec(st+m)=m;
%     end
% end
% self.smf=sind(mvec*fir)';
% self.cmf=cosd(mvec*fir)';