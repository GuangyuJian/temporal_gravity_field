function[myts]=sf2ts(mysf,study_basin)


grid=mysf.value;


[tws1,S]=sol_sf.grid2ts(grid,study_basin);
myts=sol_ts(tws1,mysf.unit);

myts.set_time(mysf.time,mysf.int_year,mysf.int_month);

myts.name=[study_basin.name ];
study_basin.area_size=S;

end