function [obj2]=ts_mov(obj1,windows)                               
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
    tempts=obj1(k);

    temp2 = math_MovingAverage(tempts.value,windows);
    n=windows-1;
    n=n/2;
%     h(k)=plot(tempts.time(n+1:end-n),temp2(n+1:end-n),'LineWidth',1.5);
    ntime=length(obj1(k).time);
    obj2(k)=obj1.extra(n+1:ntime-n);
    obj2(k).value=temp2(n+1:ntime-n);

 end                             
                              
                              
                              
end

