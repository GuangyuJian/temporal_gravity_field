function self=set_single(self,fir,ceta)
%   this method set the boundary vector in obejct"study_basin"
%   and setting the fir and ceta of obeject(self).
%   this method is used to for studying a sinle point
%**************************************************************************
% In   :
%       self            [object] a object from the class "study_basin"
%       fir             [1 x 1] fir vector of boundary
%       ceta            [1 x 1] ceta  vector of boundary 
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-23
% Encode: UTF-8
%**************************************************************************
%

self.ceta=ceta;
self.fir=fir;
[self.grid_fir,self.grid_ceta]=meshgrid(self.fir,self.ceta);
Disp_Clock;
disp("单点解决方案创建成功");


end