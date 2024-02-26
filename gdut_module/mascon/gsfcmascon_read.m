filename='gsfc.glb_.200204_202309_rl06v2.0_obp-ice6gd_halfdegree.nc';
info=ncinfo(filename);
%%
ewh=ncread(filename,'lwe_thickness');
ewh=rot90(ewh*10,1); 
%%
ewh=[ewh(:,361:720,:) ewh(:,1:360,:) ];
%%
% time=ncread(filename,'time');
% lon=ncread(filename,'lon');
% lat=ncread(filename,'lat');
%%
load('csrshcdo60.mat')
time=inshc.time;
int_year=inshc.int_year;
int_month=inshc.int_month;

%%
mygsfc=study_basin(0.5);
sfgsfc=sol_sf(ewh(:,:,1:216),'ewh (mm)',mygsfc.fir,mygsfc.ceta);
sfgsfc.set_time(time,int_year,int_month);
%%

%%
land_mask=ncread(filename,'land_mask');
land_mask=rot90(land_mask,1);
land_mask=[land_mask(:,361:720,:) land_mask(:,1:360,:) ];
