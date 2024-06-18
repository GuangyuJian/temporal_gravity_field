function [self]=get_harmonic(self,varargin)
% usage:
%       if self== @sol_ts or @sol_sf 
%       self.get_harmonic 
%       self.get_harmonic(trange) 
%       ----------------------------------
%       if self == @sol_sf 
%       self.get_harmonic（trange,'mask');
%----------------------------------------------------------------------------
% In   : self   [1x1]   @sol_ts          or          @sol_sf
%        varargin option:
%                       self.get_harmonic           self.get_harmonic
%                       self.get_harmonic(trange)   self.get_harmonic(trange)   
%                                                   self.get_harmonic(trange,mask)   
%       
%       if trange is missing, the algorithm automatically calculate the
%       whole period of the self.time
% 
%       trange=[int_year1 int_month1 int_year2 int_month2]; 
%       e.g., trange=[2002,4,2022,12] means the harmonic parameters
%       estimated from 200204-202212
%     
%       mask    [rrxcc] mask of study_basin
%       note: if mask is given, the algorithm only calculate the harmonic
%       parameters over the mask.
% 
% Out  :
%       self    [1x1]  @sol_ts or @sol_sf updating the harmonic of self(@sol)
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

for k=1:length(self)
tempself=self(k);
tt=tempself.time;


switch class(tempself)

    case 'sol_sf'
        %         [ou]=sf2harmonic(self,varargin);
        if nargin==1
            [ou]= fit_harmonic_sf(tt,tempself.value);
        elseif nargin==2

            trange=varargin{1};
            ymd1=trange(1)+(trange(2)-0.5)/12;
            ymd2=trange(3)+(trange(4)-0.5)/12;

            lc=find(tt>ymd1&tt<ymd2);
            tt=tt(lc);
            [ou]= fit_harmonic_sf(tt,tempself.value(:,:,lc));
        elseif nargin==3
            trange=varargin{1};

            mask=varargin{2};
            ymd1=trange(1)+(trange(2)-0.5)/12;
            ymd2=trange(3)+(trange(4)-0.5)/12;

            lc=find(tt>ymd1&tt<ymd2);
            tt=tt(lc);
            [ou]= fit_harmonic_sf_mask(tt,tempself.value(:,:,lc),mask);

        end

    case 'sol_ts'

        if nargin==1
            [temp]= fit_harmonic_ts(tt,tempself.value);
            ou=temp;
        elseif nargin==2
            trange=varargin{1};
            ymd1=trange(1)+(trange(2)-0.5)/12;
            ymd2=trange(3)+(trange(4)-0.5)/12;

            lc=find(tt>ymd1&tt<ymd2);
            tt=tt(lc);
            [temp]= fit_harmonic_ts(tt,tempself.value(lc));
            ou=temp;
        end
end
self(k).harmonic=ou;
end
end

