function[myts]=sf2ts(mysf,study_basin)


grid=mysf.value;


[tws1,S]=sol_sf.grid2ts(grid,study_basin);
myts=sol_ts(tws1,mysf.unit);


myts.int_year=mysf.int_year;
myts.int_month=mysf.int_month;   
myts.time=mysf.time;
myts.name=study_basin.name;


end