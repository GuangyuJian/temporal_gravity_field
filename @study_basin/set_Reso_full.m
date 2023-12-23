function set_Reso_full(self,Resolution)
%   this method set the resolution in obejct"study_basin" and setting the 
%   fir and ceta of project(self).
%   the resolution for both fir and ceta direction is the same
%   the first and last element in fir/ceta vector is the same.
%**************************************************************************
% In   :
%       self        [object]        , a object from the class "study_basin"
% 
%       Resolution: [1x1]           ,unit: degree
%                   recommended option {0.125; 0.25; 0.5; 1}
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
self.Resolution=d;

if nargin==2
    self.ceta=90:-d:-90;
    self.fir=-180:1:180-1;

end
% [self.grid_fir,self.grid_ceta]=meshgrid(self.fir,self.ceta);
self.get_mask(self.boundary_fir,self.boundary_ceta);

end