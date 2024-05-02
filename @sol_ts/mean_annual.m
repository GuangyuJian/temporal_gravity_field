function [mean_an]=mean_annual(self,trange,filling_flag)
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
% date: 2024-03-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
if nargin==2
filling_flag=2;

end

if filling_flag==1

selftemp=self.filling(trange);
else
    y1=self.int_year(1);
    m1=self.int_month(1);

    y2=self.int_year(end);
    m2=self.int_month(end);
    selftemp=self.extra('trange',[ y1 m1 y2 m2]);
end

y1=trange(1);
y2=trange(3);
m1=trange(2);
m2=trange(4);

ymd1=y1+(m1-0.5)/12;
ymd2=y2+(m2-0.5)/12;

lc=find(selftemp.time<=ymd2&selftemp.time>=ymd1);

if mod(length(lc),12)==0

    selftemp=selftemp.extra('trange',trange);
    int_year=selftemp.int_year;
    int_month=selftemp.int_month;
    tws=selftemp.value;

    for mm=1:12
        lc=find(int_month==mm);
        mean_an(mm,1)=mean(tws(lc));
    end
else
    error('非整数年');

end
mean_an=mean_an-mean(mean_an);
end

