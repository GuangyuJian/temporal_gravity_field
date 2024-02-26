function[varout]=shp_xy2range(boundary_fir,boundary_ceta)

temp_ceta=boundary_ceta;
temp_fir=boundary_fir;

cmax=max(temp_ceta);
fmax=max(temp_fir);

cmin=min(temp_ceta);
fmin=min(temp_fir);

varout={fmin,fmax,cmin,cmax};
end