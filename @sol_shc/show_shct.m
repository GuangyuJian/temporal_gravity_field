function [h,csnm]=show_shct(self,n,m,type)
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
% date: 2024-03-22
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

loc= get_nm(n,m);

sht=storage_shct2sht(self.storage);
nl=length(sht)/2;

snm=sht(nl+loc,:);
cnm=sht(loc,:);
switch type

    case 'c'
        h=plot(self.time,cnm);
        csnm=cnm;
    case 's'
        h=plot(self.time,snm);
        csnm=snm;
end

end

