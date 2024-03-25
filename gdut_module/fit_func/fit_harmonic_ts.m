
function[ou]=fit_harmonic_ts(t,tws,t2)
% input:t应该为列向量
%           tws为列向量
if nargin<=3
    t1=[];
    tws_temp=[];
    if size(t,2)>1&&size(t,1)>1
        disp("t_format_error");
        
    else
        if size(t,2)~=1
            t1=t';
        else
            t1=t;
        end
        
        if nargin==2
           t2=2003:1/12:2018; 
        end
        
        if size(t2,2)~=1
            t2=t2';
        else

        end
        
        if size(tws,2)~=1
            tws_temp=tws';
        else
            tws_temp=tws;
        end
    end
    X1=[ones(size(t1,1),1) t1 cos(2*t1*pi) sin(2*t1*pi)  cos(4*t1*pi)  sin(4*t1*pi)     ];
    X2=[ones(size(t2,1),1) t2 cos(2*t2*pi) sin(2*t2*pi)  cos(4*t2*pi)  sin(4*t2*pi)     ];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               0
%     [b1,bint,~,~,~,] = regress(tws_temp,X1);
    [b1,~,r,~,~] = regress(tws_temp,X1);
    n=size(X1,1);
    t=length(b1);
    sigma=r'*r/(n-t);
    Dbb=sigma*inv(X1'*X1);
    
    Amp1=Root_Sum2(b1(3),b1(4));
    Amp1_std=[];
    Pha1=get_phase(b1(3),b1(4),Amp1);
    Pha1_std=[];
    Amp2=Root_Sum2(b1(5),b1(6));
    Amp2_std=[];
    Pha2=get_phase(b1(5),b1(6),Amp2);
    Pha2_std=[];
    
    ma1=2*sqrt((b1(3)/Amp1)^2*Dbb(3,3)+ (b1(4)/Amp1)^2*Dbb(4,4));
    ma2=2*sqrt((b1(5)/Amp2)^2*Dbb(5,5)+ (b1(6)/Amp2)^2*Dbb(6,6));
    mp1=2*sqrt(Dbb(3,3) * (b1(4)^2/Amp1^4)+ Dbb(4,4) * (b1(3)^2/Amp1^4));
    mp2=2*sqrt(Dbb(5,5) * (b1(6)^2/Amp2^4)+ Dbb(6,6) * (b1(5)^2/Amp2^4));
    
     mp1=2*sqrt(Dbb(3,3) * (b1(4)/Amp1^2)^2+ Dbb(4,4) * (b1(3)/Amp1^2)^2);
    mp2=2*sqrt(Dbb(5,5) * (b1(6)/Amp2^2)^2+ Dbb(6,6) * (b1(5)/Amp2^2)^2);
    
    mp1=rad2deg(mp1);
    mp2=rad2deg(mp2);
    
    Trend=b1(2);
    if nargin==2
        Trend_std=[];
        Trend_line=X1(:,1:2)*b1(1:2,:);
        Interp=X1*b1;
        Resid=tws_temp-X1*b1;
    else
        Trend_std=[];
        Trend_line=X2(:,1:2)*b1(1:2,:);
        Interp=X2*b1;
        Resid=tws_temp-X1*b1;
    end
   
    info=[Amp1 ma1;Pha1 mp1;Amp2 ma2;Pha2 mp2];
    Trend_std=Dbb(2,2);
    %%
    % varout={Amp1,Amp1_std,Pha1,Pha1_std,Amp1,Amp1_std,Pha1,Pha1_std,Trend, Trend_std, Trend_line, Resid, Interp}
%     varargout={Amp1,Pha1,Amp2,Pha2,Trend,Trend_line, Resid, Interp,b1,X1,X2,Amp1bint,Pha1bint,Amp2bint,Pha2bint,Trendbint};
        ou=[info;Trend,Trend_std];%, ...
%     varargout={info,Trend,Trend_std,Trend_line,Resid};%, ...
%         Amp1bint,Pha1bint,Amp2bint,Pha2bint,Trendbint};

%     bintout={Amp1bint,Pha1bint,Amp2bint,Pha2bint,Trendbint};
end
end

function[RS2]=Root_Sum2(c,s)
% Root_Sum2
% sqrt(x1^2+x2^)
RS2=sqrt(c^2+s^2);
end

function Pha=get_phase(c,s,Amp)

if s>0  %  sin >0 [0, pi/2], [pi/2, pi]
    Pha = acos(c/Amp);
elseif s<0 % sin<0 [pi, 3*pi/2], [3*pi/2, 2*pi]
    Pha = 2*pi - acos(c/Amp);
elseif s==0 && c==1
    Pha = 0;
elseif s==0 && c==-1
    Pha = pi;
elseif s==0 && c==0
    Pha = 0;
end
% from radian measure to angle measure
Pha  = Pha*180/pi;
% from angle measure to day in the year
% Pha  = Pha*365/360;
end