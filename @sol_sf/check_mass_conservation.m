function [tso,tsl]=check_mass_conservation(mysf,ocean_mask)
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
% date: 2024-02-23
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

d=180/size(mysf.value,1);

mybo=study_basin(d);
mybo.mask=ocean_mask;
mybl=study_basin(d);
mybl.mask=1-ocean_mask;

[~,so]=sol_sf.grid2ts(mysf.value(:,:,1),mybo);
[~,sl]=sol_sf.grid2ts(mysf.value(:,:,1),mybl);


tso=mysf.sf2ts(mybo);
tsl=mysf.sf2ts(mybl);
tsl.value=tsl.value*sl;
tso.value=-tso.value*so;
% tsl=tsl*sl;
% tso=tso*so;

end

