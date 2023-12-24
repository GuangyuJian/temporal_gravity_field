function self=get_mask(self,bf1,bc1,bf2,bc2)
%   this method generate a  mask matrix corresponding 
%   the boundary of our study basin
%   the object will memory the mask in its own propeties(mask)
%**************************************************************************
% In   :
%       self              [object] a object from the class "study_basin"
%       bf1,bc1,bf2,bc2   [n x 1] there are vector of boundary
%       f and c mean the fir and ceta vectors, respectively
%       the number 1 and 2 mean the external and internal edge
% Out  :
%       mask            [nc x nf] a 0-1 matrix 
%       (0/1 means  external/internal point of the basin)
%       the size of mask is decided by the pre-set resolution of self(). 
%       for example, when resolution=1, nc=180, and nf=360
%       if you feel confused about the mask, you can print it out.
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-23
% Encode: UTF-8
%**************************************************************************
%


fir=self.fir;
ceta=self.ceta;

if nargin==5
    self.boundary_fir=[bf1,NaN,bf2];
    self.boundary_ceta=[bc1,NaN,bc2];
    [M,C]=boundary2grid(fir,ceta,bf1,bc1,bf2,bc2);
    
elseif nargin==3
    self.boundary_fir=bf1;
    self.boundary_ceta=bc1;
    [M,C]=boundary2grid(fir,ceta,bf1,bc1);

elseif nargin<3 
   error('check');
end

self.mask=M;
self.cos_weight_grid=C;
disp("mask is done")
end

function [mask,cos_weight_grid]=boundary2grid(M_fir,M_ceta,bf1,bc1,bf2,bc2)

fir=M_fir;
ceta=M_ceta;

if ~isrow(fir)
error('longititude vector is not row vector');
end

if ~isrow(ceta)
error('latitude vector is not row vector');
end
fir=fir(:)';
ceta=ceta(:)';



[x,y]=meshgrid(M_fir,M_ceta);
if nargin==4
    mask=inpolygon(x,y,bf1,bc1);
    temp=repmat(cosd(ceta)',[size(fir)]);
%     cos_weight_grid=temp.*mask/sum(temp.*mask,"all");
    cos_weight_grid=temp;%.*mask/sum(temp.*mask,"all");
elseif nargin==6
    mask1=inpolygon(x,y,bf1,bc1);
    mask2=inpolygon(x,y,bf2,bc2);
    mask=mask1-mask2;
    temp=repmat(cosd(ceta)',[size(fir)]);
%     cos_weight_grid=temp.*mask/sum(temp.*mask,"all");
    cos_weight_grid=temp;%.*mask/sum(temp.*mask,"all");
end
%

%

end