function [tt1,X3]=ssa_ys(ser,trange)                               
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
% date: 2024-02-02
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8  
%**************************************************************************
%Ref:
%**************************************************************************
                              
%% generate uniformly spaced time series
[tt1,X1] = uniform_time(ser(:,1),ser(:,2), trange);
% tt1: equal-spaced time, from April 2002 to August 2020 (defined by the third input)
% X1: rearranged C(3,0), NaN is assigned to gaps

%% SSA-filling-a
ind_nan = isnan(X1);
id = zeros(size(tt1)); % classify observations and gaps by id
id(tt1<2017.5 & ~ind_nan) = 1; % 1: GRACE
id(tt1>2017.5 & ~ind_nan) = 2; % 2: GFO
id(tt1<2017.5 & ind_nan) = 3;  % 3: gaps within GRACE
id(tt1>2017.5 & ind_nan) = 4;  % 4: the 11-month gap & a gap within GFO

MM = 24; % Window size
KK = 10; % Maximum number of RCs to be used
[X2,verror1] = fun_SSA_filling_a(X1,id, MM, KK);
% X2: results after SSA-filling-a gaps (id = 3) are filled.
% verror1: error estimation, based on fitting residuals

%% SSA-filling-b
Mlist = 24:12:96; 
Klist = [1,2:2:12]; 

% The following code traverses Mlist & Klist to implement the cross validation to find 
% the optimal parameter set.
% If both Mlist and Klist consist of only one element, the value will be used
% directly.
[X3,verror2,opt_MK] = fun_SSA_filling_b(tt1,X2,Mlist,Klist);
% X3: final output, all gaps are filled
% verror2: error esimation, based on the cross validation (if implemented, 
%          otherwise based on fitting residuals).
                        
                              
end

