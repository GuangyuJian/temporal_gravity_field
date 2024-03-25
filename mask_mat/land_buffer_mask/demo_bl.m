
load coast.mat
%%
plot(long,lat)
%%
clc;
v=[long,lat];
Ployout=polybuffer(v,'lines',3);
clc;
%%
solcsr.set_Resolution(0.5);
solcsr.get_mask(long,lat)
solcsr.plot_region

original_mask=solcsr.mask;
land_mask=original_mask;
ocean_mask=1-land_mask;
%%
x=Ployout.Vertices(:,1);
y=Ployout.Vertices(:,2);
solcsr.set_Resolution(0.5);
solcsr.get_mask(x,y);

mask_buffer=solcsr.mask;
%%
mask_r05_bufferg300=original_mask+mask_buffer;
mask_r05_bufferg300(find(mask_r05_bufferg300>0))=1;
mask_r05_bufferg300(349:end,:)=1;
%%

mask_r025_bufferg300=original_mask+mask_buffer;
mask_r025_bufferg300(find(mask_r025_bufferg300>0))=1;
mask_r025_bufferg300(696:end,:)=1;
%%
mask_r3_bufferg300=original_mask+mask_buffer;

mask_r3_bufferg300(find(mask_r3_bufferg300>0))=1;
mask_r3_bufferg300(59:60,:)=1;
%%
