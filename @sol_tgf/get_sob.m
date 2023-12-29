function [self]=get_sob(self)
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

sol_filter= self.sol_filter;
study_basin= self.study_basin;

maxn=sol_filter.maxn;

ceta=study_basin.ceta;
fir =study_basin.fir;

x=cosd(90-ceta);
self.pnm=math_NormLegendre(maxn,x);%完全规格化连带勒让德系数


mvec=zeros(2+(maxn+2)*(maxn-1)/2,1);
for n=0:maxn
    st=2+(n+2)*(n-1)/2;
    for m=0:n
        mvec(st+m)=m;
    end
end
self.smf=sind(mvec*fir)';
self.cmf=cosd(mvec*fir)';


end

