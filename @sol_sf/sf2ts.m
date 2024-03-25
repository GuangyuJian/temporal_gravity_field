function[myts]=sf2ts(mysf,myb)


grid=mysf.value;


[tws1,S]=sol_sf.grid2ts(grid,myb);
myts=sol_ts(tws1,mysf.unit);

myts.set_time(mysf.time,mysf.int_year,mysf.int_month);

myts.name=[myb.name ];
myb.area_size=S;

end