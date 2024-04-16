function [obj2]=ts_nor(obj1)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-06
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
for k=1:length(obj1)

    obj2(k)=obj1(k)-obj1(k);
    obj2(k).value=obj1(k).value/std(obj1(k).value);

end

end

