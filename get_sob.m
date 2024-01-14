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