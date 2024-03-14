function [myvsf]=vshc2sf(myvshc,myf,myb,type)
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
% date: 2024-03-14
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
for k=1:length(myvshc)
    myvsf(k)=shc2sf(myvshc(k),myf,myb,type);
end



end

