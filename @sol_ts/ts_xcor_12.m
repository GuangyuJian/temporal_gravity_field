function [rlagsinfo,lagsinfo,rinfo]=ts_xcor_12(obj1,obj2)
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
    temp1=obj1(k);
    y1=temp1.int_year(1);
    y2=temp1.int_year(end);
    m1=temp1.int_month(1);
    m2=temp1.int_month(end);

    temp2=obj2.extra('trange',[y1 m1 y2 m2]);
    if length(temp1.time)~=length(temp2.time)
    error('');
    end
    [r,lags]=xcorr(temp1.value,temp2.value,12,"normalized");
    [~,i]=max(abs(r));
    rlagsinfo(k)=r(i);
    lagsinfo(k)=lags(i);
    rinfo(k)=r(13);
end

end

