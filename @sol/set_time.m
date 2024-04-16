function [self]=set_time(self,time,int_year,int_month)
%
%----------------------------------------------------------------------------
% In   : self       [1xn]   @sol
%        time       [1xn]   fraction of year
%        int_year   [1xn]   year
%        int_month  [1xn]   month
% Out  :
%       self        [1xn]   @sol
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-15
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
for k=1
    n1=length(time);
    n2=length(int_year);
    n3=length(int_month);
    if n1~=n2&&n2~=n3
        error('!');
    end
%     if n1==0||n2==0||n3==0
%         error('!');
%     end
    self(k).time=time;
    self(k).int_year=int_year;
    self(k).int_month=int_month;
end

end

