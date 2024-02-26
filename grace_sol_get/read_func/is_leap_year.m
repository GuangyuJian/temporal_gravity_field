function [flag]=is_leap_year(int_year)
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
% date: 2024-02-05
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
if       ( mod(int_year,4)==0 &&  mod(int_year,400)~=0 ) || mod(int_year,400)==0
    flag=1;
else
    flag=0;
end

end

