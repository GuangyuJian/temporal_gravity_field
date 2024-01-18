function []=obs2map_tt(self,varargin)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-13
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
% tt,value,titlename
nin=length(varargin);
if nin==3


elseif nin==2

    tt=varargin{1};
    cvalue=varargin{2};
    titlename=[];
elseif nin==1
    tt=varargin{1};
    cvalue=varargin{2};
    titlename=varargin{3};
end

if ~isempty(self.time)

    iy=self.int_year(tt);
    im=self.int_month(tt);

    if im<10
        titlestr=([num2str(iy) '0' num2str(im) ]);
    else
        titlestr=([num2str(iy) num2str(im) ]);
    end
    title(titlestr);
end
if ~isempty(titlename)
    titlename=titlestr;
end




range=self.show_range;
ewh=self.value(:,:,tt);

obs2map_fs12(ewh,cvalue,range,titlename);



end

