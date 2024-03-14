function [obj2]=truncate_m(obj1,maxm)                               
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
                  
% en=get_en(maxnnew);
maxn=obj1.maxn;
storage=obj1.storage;
for k=1:length(storage)
    
    for m=maxm:maxn
        n=m:maxn;
        lc=get_nm(n,m);
        storage(k).cnm(lc)=0;
        storage(k).snm(lc)=0;
    end
end

   obj2=sol_shc(storage,maxn,obj1.storage_type,obj1.type);
   obj2.set_time(obj1.time,obj1.int_year,obj1.int_month);
                              
end

