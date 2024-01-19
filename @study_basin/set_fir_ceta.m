function set_fir_ceta(self,fir,ceta)
%   this method set the boundary vector in obejct"study_basin"
%  and setting the fir and ceta of obeject(self).
%**************************************************************************
% In   :
%       self            [object] a object from the class "study_basin"
%       fir             [n x 1] fir vector of boundary
%       ceta            [n x 1] ceta  vector of boundary 
%----------------------------------------------------------------------------

% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-23
% Encode: UTF-8
%**************************************************************************
%


self.ceta=ceta;%纬度latitude
self.fir=fir;%经度longitude
[self.grid_fir,self.grid_ceta]=meshgrid(self.fir,self.ceta);
% self.get_Coe(); ignore it
end