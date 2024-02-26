function [mon,day]=yds2md(int_year,days)
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


if int_year<0 || days<0 || days>366
    error('Wrong input parameter in yds2md Function!')
end
% day1=0 means starter in origin 0 
% it make sure fraction in years becomed a left-closed interval

if days ==0
    %     mon =1;
    %     day =1;
    day=0; %modified by k.j
    mon=12;
    return
end

if ( mod(int_year,4)==0 &&  mod(int_year,400)~=0 ) || mod(int_year,400)==0 % leap year
    d1=[0,31,59,90,120,151,181,212,243,273,304,334,365];
else
    d1=[0,31,60,91,121,152,182,213,244,274,305,335,366]; % leap year
end

for i=1:12
    if days>d1(i) && days<=d1(i+1)
        mon =i;
        day = days - d1(i);
        return
    end
end

end

