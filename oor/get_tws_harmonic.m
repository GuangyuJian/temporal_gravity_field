function [info,std,trend_line,residual]=get_tws_harmonic(t,mat,t2)



for c1=1:size(mat,2)
    
%     [Amp1,Pha1,Amp2,Pha2,trend,Trend_line,Resid, Interp,b1,X1,X2]=Fit_harmonic(t,mat(:,c1),t2);
    [ap,trend,trendstd,Trend_line,re]=Fit_harmonic_v3(t(:)',mat(:,c1),t2);
%     amp_pha(1,c1)=Amp1;
%     amp_pha(2,c1)=Pha1;
%     amp_pha(3,c1)=Amp2;
%     amp_pha(4,c1)=Pha2;
%     ap(:,c1)=info(:,1);
%     apstd(:,c1)=info(:,2);
%     Trend(1,c1)=trend;
%     cycle(:,c1)=X2(:,3:end)*b1(3:end,:);

info(1:4,c1)=ap(:,1);
std(1:4,c1)=ap(:,2);

info(5,c1)=trend;
std(5,c1)=trendstd;

    trend_line(:,c1)=Trend_line(:);
    residual(:,c1)=re;
%     amp_pha(1,c1)=Amp1-Amp1bint;,Amp1bint,Pha1bint,Amp2bint,Pha2bint,Trendbint
%     amp_pha(2,c1)=Pha1;
%     amp_pha(3,c1)=Amp2;
%     amp_pha(4,c1)=Pha2;
%     Trend_bint=Trend-Trendbint;
end

end