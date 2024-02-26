filename='GRCTellus.JPL.200204_202311.GLO.RL06.1M.MSCNv03CRI (1).nc';
info=ncinfo(filename);
ewh=ncread(filename,'lwe_thickness');
ewh=rot90(ewh*10,1);
ewh=[ewh(:,361:720,:) ewh(:,1:360,:) ];
time=ncread(filename,'time');
land_mask=ncread(filename,'land_mask');
land_mask=rot90(land_mask,1);

land_mask=[land_mask(:,361:720,:) land_mask(:,1:360,:) ];
% lon=ncread(filename,'lon');
% lat=ncread(filename,'lat');

scale_factor=ncread(filename,'scale_factor');
scale_factor=rot90(scale_factor,1);
scale_factor=[scale_factor(:,361:720,:) scale_factor(:,1:360,:) ];
%%
load('csrshcdo60.mat')
time=inshc.time;
int_year=inshc.int_year;
int_month=inshc.int_month;

%%
myjpl=study_basin(0.5);
sfjpl=sol_sf(ewh(:,:,1:216),'ewh (mm)',myjpl.fir,myjpl.ceta);
sfjpl.set_time(time,int_year,int_month);
%%
