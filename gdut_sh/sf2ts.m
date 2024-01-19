function[myts]=sf2ts(sol_sf,study_basin)


grid=sol_sf.value;


[tws1,S]=grid2ts(grid,study_basin);
myts=sol_ts(tws1,sol_sf.unit);


myts.int_year=sol_sf.int_year;
myts.int_month=sol_sf.int_month;   
myts.time=sol_sf.time;
myts.name=study_basin.name;


end