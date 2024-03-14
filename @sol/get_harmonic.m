function [self]=get_harmonic(self,varargin)
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
% date: 2024-02-03
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
tt=self.time;


switch class(self)

    case 'sol_sf'
        %         [ou]=sf2harmonic(self,varargin);
        if nargin==1
            [ou]= fit_harmonic_sf(tt,self.value);
        elseif nargin==2

            trange=varargin{1};
            ymd1=trange(1)+(trange(2)-0.5)/12;
            ymd2=trange(3)+(trange(4)-0.5)/12;

            lc=find(tt>ymd1&tt<ymd2);
            tt=tt(lc);
            [ou]= fit_harmonic_sf(tt,self.value(:,:,lc));
        elseif nargin==3
            trange=varargin{1};

            mask=varargin{2};
            ymd1=trange(1)+(trange(2)-0.5)/12;
            ymd2=trange(3)+(trange(4)-0.5)/12;

            lc=find(tt>ymd1&tt<ymd2);
            tt=tt(lc);
            [ou]= fit_harmonic_sf_mask(tt,self.value(:,:,lc),mask);

        end

    case 'sol_ts'

        if nargin==1
            [temp]= fit_harmonic_ts(tt,self.value);
            ou=temp;
        elseif nargin==2
            trange=varargin{1};
            ymd1=trange(1)+(trange(2)-0.5)/12;
            ymd2=trange(3)+(trange(4)-0.5)/12;

            lc=find(tt>ymd1&tt<ymd2);
            tt=tt(lc);
            [temp]= fit_harmonic_ts(tt,self.value(lc));
            ou=temp;
        end
end
self.harmonic=ou;

end

