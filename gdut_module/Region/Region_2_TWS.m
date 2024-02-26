function[tws1,S,tws2]=Region_2_TWS(mat,Sol)
% n1=size(time,1);
% n2=size(time,2);
% n=max([n1,n2]);
ewh=mat;
ae        =  6378136.3;
mask=Sol.mask;
cos_weight_grid=Sol.cos_weight_grid;
n=size(ewh,3);
tws=zeros(n,1);

if size(ewh,1)~=size(mask,1)|size(ewh,2)~=size(mask,2)
    Disp_Clock;
    disp('Region_2_TWS:尝试计算中，ewh与mask不同纬度');
    disp(Sol);
end
% [rl]=find(isnan(ewh(:,:,1)));
% Mnan=zeros(size(mask));
% Mnan(rl)=1;
% [lc]=find(Mnan.*mask==1);
% if ~isempty(lc)
%     for k=1:n
%         temp=  ewh(:,:,k);
%         temp(find(isnan(temp)))=0;
%         ewh(:,:,k)=temp;
%     end
% end


for k=1:n
    temp=  ewh(:,:,k)    .*mask(1:size(ewh,1),1:size(ewh,2))  .*cos_weight_grid(1:size(ewh,1),1:size(ewh,2));
    m=sum(mask(1:size(ewh,1),1:size(ewh,2)) .*cos_weight_grid(1:size(ewh,1),1:size(ewh,2)),'all');
    tws(k,1)=sum(  temp ,'all')/m;
end

d=Sol.Resolution(1);
temceta=90-d/2:-d:-90+d/2;
temfir=-180+d/2:d:180-d/2;
s_globe=sum(cosd(temceta)*length(temfir));


tws1=tws;

lc=find(isnan(Sol.time));
% tws2=[tws(1:lc-1)' nan tws(lc:end)'];
% S=m/s_globe*ae* ae/10^6*deg2rad(d)^2;
S=m*ae* ae/10^6*deg2rad(d)^2;%unit :km面积
end