function [h]=tsa_xwt(obj1,obj2)
% cross wavelet analysis for two time series
% need external module name wavelet-coherence-master toolbox
% http://www.glaciology.net/wavelet-coherence
%----------------------------------------------------------------------------
% In   : obj1 @sol_ts
%        obj2 @sol_ts
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-03-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

tws1=[obj1.time(:),obj1.value(:)];
tws2=[obj2.time(:),obj2.value(:)];
xwt(tws1,tws2);
% colorbar off;
h=gca;
ylabel('周期（年）');
xlabel('年');
set(gca,'FontSize',10)
end
