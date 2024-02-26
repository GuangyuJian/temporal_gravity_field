function [ou]=value_nse(x,y)
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
% date: 2024-01-26
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

% ou= rms(self.value,3);


top=sum((x-y).^2,3);
temp=x-mean(x,3);
bottom=sum((temp).^2,3);
clear temp;
ou=1-top./bottom;

end

