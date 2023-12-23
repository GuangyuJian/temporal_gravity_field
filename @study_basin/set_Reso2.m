function set_Reso2(self,Resolution,box)
%   this method set the resolution in obejct"study_basin" and setting the 
%   fir and ceta of obeject(self).
%   the resolution for both fir and ceta direction can be different
%**************************************************************************
% In   :
%       self        [object]        , a object from the class "study_basin"
% 
%       Resolution: [1x2] or [2 x 1],unit: degree
%                   
%
%       box:        [1x4]or[4x1]    ,unit: degree;
%                   [minimum of longitude,maximum of longitude,
%                   minimum of ceta,maximum of ceta]
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-23
% Encode: UTF-8
%**************************************************************************
%


d=Resolution;
if length(d)~=2
    
error('分辨率函数使用错误');
end
self.Resolution=d;
d1=d(1);
d2=d(2);

if nargin==2
    self.ceta=90-d1/2:-d1:-90+d1/2;
    self.fir=-180+d2/2:d2:180-d2/2;
    
elseif nargin==3
    %                     box [fmin,fmax,cmin,cmax]
        if length(box)<4
        error('mybasin: please check your box');
    end

    self.ceta=box(4)-d1/2:-d:box(3)+d1/2;
    self.fir=box(1)+d2/2:d:box(2)-d2/2;
end
% [self.grid_fir,self.grid_ceta]=meshgrid(self.fir,self.ceta);
self.get_mask(self.boundary_fir,self.boundary_ceta);

end