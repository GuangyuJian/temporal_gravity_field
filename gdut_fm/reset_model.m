function [model1]=reset_model(model1,land_mask,ocean_mask,myb)
myb.mask=land_mask;
[ml,sl]=sol_sf.grid2ts(model1,myb);

myb.mask=ocean_mask;
[~,so]=sol_sf.grid2ts(model1,myb);
mo=-ml*so/sl;

model1=model1.*land_mask+mo.*ocean_mask;
end