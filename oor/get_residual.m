function [residual2]=get_residual(t1,tws,lc)
%计算非季节性变化
% [residual2]=get_residual(t1,tws,lc)
%&Anomaly
%
t1=t1(:)';
tws=tws(:);
if nargin==3
[~,~,~,t2tws(1,:),trend_line2tws(1,:),~]=Fit_Trend_diff_n_period(t1,tws(:),lc);
twstem2=tws-trend_line2tws(~isnan(t2tws))';
elseif nargin==2
    [~,trend_line2tws]=Fit_Trend(t1,tws,t1);
    twstem2=tws-trend_line2tws;
end

[~,~,~,residual2]=get_tws_harmonic(t1,twstem2,t1);


end