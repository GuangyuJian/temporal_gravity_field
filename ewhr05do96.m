function [sf]=ewhr05do96(myshc)
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
% date: 2024-03-28
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************


myf=sol_filter(96);
myb=study_basin(0.5);
sf=vshc2sf(myshc,myf,myb,'mc');
end

