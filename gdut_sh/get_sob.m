function [pnm,cmf,smf,ds]=get_sob(sol_filter,study_basin)
% this function get the Spherical orthogonal basis (SOB) for using Spherical 
% harmonic synthesis (SHS)
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
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

maxn=sol_filter.maxn;
ceta=study_basin.ceta;
fir =study_basin.fir;

x=cosd(90-ceta);

pnm=math_NormLegendre(maxn,x);%完全规格化连带勒让德系数

mm=0:maxn;
smf=sind(fir(:)*mm)';
cmf=cosd(fir(:)*mm)';


% mvec=zeros(2+(maxn+2)*(maxn-1)/2,1);
% for n=0:maxn
%     st=2+(n+2)*(n-1)/2;
%     for m=0:n
%         mvec(st+m)=m;
%     end
% end
% smf=sind(mvec*fir)';
% cmf=cosd(mvec*fir)';


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
%     Lmax:最高阶数
%     x    :纬度对应的余维度的余弦值
%Ouput
%     Coe_P:完全规格化的勒让德系数
%===============================================
k=length(x);
% Pnm=zeros(Lmax+1);
if size(x,1)~=1
   x=x'; 
end
% if Lmax>200
%     h=waitbar(0,'正在加载勒让德函数');
% end
for l=0:Lmax
    p=legendre(l,x,'norm');%归一化连带勒让德系数
    st=2+(l+2)*(l-1)/2;
    en=st+l;
    %完全规格化处理;
    if l==0
        m(1,1:k)=sqrt(2);
    else
        m(1,1:k)=sqrt(2);
        m(2:l+1,1:k)=2;
    end

    Coe_P(st:en,:)=p.*m;
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