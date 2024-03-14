function [obj2]=truncate(obj1,maxnnew)                               
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
% date: 2024-03-09
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
                  
en=get_en(maxnnew);
storage=obj1.storage;
for k=1:length(storage)
storage(k).cnm=storage(k).cnm(1:en);
storage(k).snm=storage(k).snm(1:en);
end

   obj2=sol_shc(storage,maxnnew,obj1.storage_type,obj1.type);
   obj2.set_time(obj1.time,obj1.int_year,obj1.int_month);
                              
end

