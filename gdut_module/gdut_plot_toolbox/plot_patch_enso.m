function []=plot_patch_enso(t1,tws,flag)
tws=tws(:);
t1=t1(:);
if flag==1
%     color1=[1 0 0];
%     color2=[0 0 1];
        color1=[1 0 0];
    color2=[0 0 1];
   color1= [1 1 0]
   color2=  [0.4940 0.1840 0.5560]
elseif flag==2
%     color2=[1 0 0];
%     color1=[0 0 1];
         color2= [1 1 0]
   color1=  [0.4940 0.1840 0.5560]
   elseif flag==3
%     color2=[1 0 0];
%     color1=[0 0 1];
         color2= [1 0 0]
   color1=  [0 0 1]
end
    
   
% lc=find(tws>0);
% tt=[t1(1);t1 ;t1(end)];
% ttws=[0;tws ;0];
% Z=zeros(size(ttws));
% Z(ttws>=0)=1;
% Z(ttws<0)=-1;
% fill (tt,ttws,Z);
tt=t1(1):1/1000:t1(end);
ttws=interp1_t2(t1,tws,tt);

% ttws=[0;tws ;0];
% lc=find(tws>0);

lc=find(ttws>0);
tt1=tt(lc);
ttws1=ttws(lc);
tt1=[tt1(1);tt1(:) ;tt1(end)];
ttws1=[0;ttws1 ;0];

patch (tt1,ttws1,...
    [220/255 220/255 220/255],...
    'Facecolor',color1,...
    'FaceAlpha',0.2,...
    'EdgeColor','none');
hold on;

lc=find(ttws<=0);
tt1=tt(lc);
ttws1=ttws(lc);
tt1=[tt1(1);tt1(:) ;tt1(end)];
ttws1=[0;ttws1 ;0];
S=patch (tt1,ttws1,...
    [220/255 220/255 220/255],...
    'Facecolor',color2,...
    'FaceAlpha',0.5,...
    'EdgeColor','none');

end