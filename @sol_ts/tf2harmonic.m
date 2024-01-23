function [myts]=tf2harmonic(myts,trange)
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
% date: 2024-01-23
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************


if nargin==1

    tt=myts.time;
    [temp]= fit_harmonic_ts(tt,myts.value);
    myts.harmonic=temp;
elseif nargin==2

    tt=myts.time;
    lc=find(tt>trange(1)&tt<trange(2));
    tt=tt(lc);
    [temp]= fit_harmonic_ts(tt,myts.value(lc));
    myts.harmonic=temp;
end

