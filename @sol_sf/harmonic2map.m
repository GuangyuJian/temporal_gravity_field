function [h]=harmonic2map(self,varargin)
% show the temporal property of sf
% usage:    self.harmonic2map('aa');  annual amplitude (self.unit)
%           self.harmonic2map('ap');  annual phase (°)
%           self.harmonic2map('saa'); semi-annual amplitude (self.unit)
%           self.harmonic2map('sap'); semi-annual phase  (°)
%           self.harmonic2map('tr');  trend （self.unit/yr）
%----------------------------------------------------------------------------
% In   : self   [1x1]   @sol_sf
%        varargin [1x1] str 
%                       optional: 'aa' 'ap' 'saa' 'sap' 'tr'
% Out  : h      [1x1]   handle of gca
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-29
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
% tt,value,titlename
% varargin={type,value}
nin=length(varargin);
if nin==2
    type=varargin{1};
    cvalue=varargin{2};
elseif nin==1
    cvalue=[-50 50];
end

  type=varargin{1};
switch type
    case   'aa'
        lc=1;
        titlename='‘annual amplitude';
    case   'ap'
        lc=2;
        titlename='‘annual phase';
    case  'saa'
        lc=3;
        titlename='‘semi-annual amplitude';
    case  'sap'
        lc=4;
        titlename='‘semi-annual phase';
    case  'tr'
        lc=5;
        titlename='‘trend';
    otherwise

        error('! wrong option');
end

range=self.show_range;
ewh=self.harmonic(:,:,lc);
titlename=[];
h=obs2map_fs(ewh,cvalue,range,titlename,10);



end

