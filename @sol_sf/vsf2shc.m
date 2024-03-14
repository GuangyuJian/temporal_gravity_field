function [my_shc]=vsf2shc(mysf,myf,myb,type)
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
for k=1:length(mysf)
    [my_shc(k)]=sf2shc(mysf(k),myf,myb,type);
end


end

