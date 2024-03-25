filename='CSR_GRACE_GRACE-FO_RL0602_Mascons_all-corrections.nc';
info=ncinfo(filename);
%%
ewh=ncread(filename,'lwe_thickness');
ewh=rot90(ewh*10,1);
%%
ewh=[ewh(:,721:1440,:) ewh(:,1:720,:) ];
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
mycsr=study_basin(0.25);
sfcsr=sol_sf(ewh(:,:,1:216),'ewh (mm)',mycsr.fir,mycsr.ceta);
sfcsr.set_time(time,int_year,int_month);
%%
filename='CSR_GRACE_GRACE-FO_RL06_Mascons_v02_LandMask.nc';
info=ncinfo(filename);
%%
land_mask=ncread(filename,'LO_val');
land_mask=rot90(land_mask,1);
land_mask=[land_mask(:,721:1440,:) land_mask(:,1:720,:) ];
