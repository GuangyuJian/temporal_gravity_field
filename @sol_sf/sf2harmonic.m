function [mysf]=sf2harmonic(mysf,trange,mask)
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
    tt=mysf.time;
    [mysf.harmonic]= fit_harmonic_sf(tt,mysf.value);
elseif nargin==2
    tt=mysf.time;
    lc=find(tt>trange(1)&tt<trange(2));
    tt=tt(lc);
    [mysf.harmonic]= fit_harmonic_sf(tt,mysf.value(:,:,lc));
elseif nargin==3
    tt=mysf.time;
    lc=find(tt>trange(1)&tt<trange(2));
    tt=tt(lc);
    [mysf.harmonic]= fit_harmonic_sf_mask(tt,mysf.value(:,:,lc),mask);
end


end

