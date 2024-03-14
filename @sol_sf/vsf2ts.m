function [myts]=vsf2ts(mysf,study_basin)                               
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
% date: 2024-03-14
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
for k=1:length(mysf)                              
                              
 [myts(k)]=sf2ts(mysf(k),study_basin) ;                            
        
end
end

