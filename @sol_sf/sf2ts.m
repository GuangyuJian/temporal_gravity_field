function[myts]=sf2ts(mysf,myb)
% [myts]=sf2ts(mysf,myb)
%----------------------------------------------------------------------------
% In   :    mysf    [1x1] @sol_sf
%                   option: 'ewh (mm)' 'uGal'
%           myb     [1x1] @study_basin
%
% Out  :
%           myts    [1x1] @sol_ts
%                   a average value of time series over study basin
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-27
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

for k=1:length(mysf)
    grid=mysf(k).value;


    [tws1,S]=sol_sf.grid2ts(grid,myb);
    myts(k)=sol_ts(tws1,mysf(k).unit);

    myts(k).set_time(mysf(k).time,mysf(k).int_year,mysf(k).int_month);

    myts(k).name=[myb.name ];
    myb.area_size=S;

end
end