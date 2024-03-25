function [c]=ger_colorbar(label)                               
% this function are used to gernerate a colorbar with the label str
% usage: c=get_colorbar('(mm)') or get_colorbar('(mm)') 
%----------------------------------------------------------------------------
% In   :    label:  [1xn] str of colorbar label
%                              
% Out  :    c   :   [1x1] a handle of colorbar object 
%                              
%----------------------------------------------------------------------------
                              
                              
% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-03-18
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
                              
 
c=colorbar;
set(c,'Units','points','fontsize',10);
c.Label.String=label;
                             
                              
                              
end

