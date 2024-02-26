function [self2]=filling(self,trange)
%[self2]=filling(self,trange)
% usage: self2=self.filling(trange)
% this method creates a new obeject with uniform interval
%----------------------------------------------------------------------------
% In   : self   [1x1] @sol_ts
%        trange [1x4] [year1,month1,year2,month2]
%        e.g. [2002,4,2022,12] means 200204->202212
% Out  :
%        self   [1x1] @sol_ts
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-02-02
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref: Yi, Shuang, 和Nico Sneeuw. 
% 《Filling the Data Gaps Within GRACE Missions Using Singular Spectrum Analysis》. 
% JOURNAL OF GEOPHYSICAL RESEARCH-SOLID EARTH 126, 期 5 (2021年5月).
% https://doi.org/10.1029/2020JB021227.
%**************************************************************************
%%
if isempty(self.time)
    error('missing a property: time');
end

if length(self.time)~=length(self.value)
    error('time and serires have different length');
end


[time,int_year,int_month]=gdut_uniform_time(trange)  ;

ser=[self.time(:),self.value(:) ];
[tt1,X3]=ssa_ys(ser,trange);
self2=sol_ts(X3,self.unit);
self2.set_time(tt1,int_year,int_month);



end

