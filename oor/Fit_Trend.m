function[varargout]=Fit_Trend(t,tws,t2)


t1=t(:);
tws_temp=tws(:);

X1=[ones(size(t1,1),1) t1   ];
[b1,~,~,~,~] = regress(tws_temp,X1);
trend=b1(2);
if nargin==3
    t2=t2(:);
    X2=[ones(size(t2,1),1) t2   ];
    trend_line=X2*b1;
elseif nargin==2
    t2=t1(:);
    X2=[ones(size(t2,1),1) t2   ];
    trend_line=X2*b1;
end
if nargout==1
    varargout={trend};
elseif nargout==2
    varargout={trend,trend_line};
end


end