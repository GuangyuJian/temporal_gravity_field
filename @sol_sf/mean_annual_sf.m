function [mean_sf]=mean_annual_sf(mysf,ts,te)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-06
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
if nargin==3
    for m=1:12
        llc=find(mysf.int_month==m);
        tempsf=mysf.extra(llc);

        mean_sf(m)=mean(tempsf.extra('trange',[ts,1,te,12]),1);

    end
elseif nargin==1
    for m=1:12
        llc=find(mysf.int_month==m);
        tempsf=mysf.extra(llc);
        mean_sf(m)=mean(tempsf,1);

    end

end

mean_sf=mean_sf-mean(mean_sf,2);

end

