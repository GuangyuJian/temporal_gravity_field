function []=plot_region(self)
%   plot three figure for showing the study basin
%  this function is mainly used to check whether our mask is correct or not
%**************************************************************************
% In   :
%       self              [object] a object from the class "study_basin"
% 
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-23
% Encode: UTF-8
%**************************************************************************


if nargin==1
    figure;
    plot_boundary(self);
    hold on;
    plot_grid(self);
    figure;
    plot_mask(self);
    figure;
    plot_cos_weight_grid(self);
end

end

function plot_mask(self)
hold on;

M=nan(size(self.mask));
M(find(self.mask==1))=1;
x=[self.fir(1),self.fir(end)];
y=[self.ceta(1),self.ceta(end)];

h=imagesc(x,y,M);
colormap(jet);
set(h,'alphadata',~isnan(M));

end

function plot_grid(self)
hold on;
x=self.grid_fir.*self.mask;
y=self.grid_ceta.*self.mask;
scatter(x(:),y(:));

end

function plot_cos_weight_grid(self)
hold on;
M=nan(size(self.cos_weight_grid));
temp=self.cos_weight_grid;
M(find(temp~=0))=temp(find(temp~=0));

x=[self.fir(1),self.fir(end)];
y=[self.ceta(1),self.ceta(end)];
h=imagesc(x,y,M);
colormap(jet);
set(h,'alphadata',~isnan(M));
end


function plot_boundary(self)
hold on;
h=mapshow(self.boundary_fir,self.boundary_ceta);

end