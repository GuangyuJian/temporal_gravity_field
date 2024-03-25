function [ou]=value_mrms(self)
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
[rows,colums,~]=size(self.value);
res=180/rows;
myb=study_basin(res);
myb.mask=ones(rows,colums);
%             ou=sf.
[ou,~]=self.grid2rms(self.value,myb)  ;
ou=ou(:);
end

