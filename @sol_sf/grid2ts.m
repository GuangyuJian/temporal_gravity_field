function[tws1,S]=grid2ts(grid,study_basin)
% n1=size(time,1);
% n2=size(time,2);
% n=max([n1,n2]);
ewh=grid;
ae        =  6378136.3;
mask=study_basin.mask;
cwg=study_basin.cos_weight_grid;
n=size(ewh,3);
tws=zeros(n,1);

if size(ewh,1)~=size(mask,1)|size(ewh,2)~=size(mask,2)
%     Disp_Clock;
    disp('Region_2_TWS:尝试计算中，ewh与mask不同纬度');
%     disp(Sol);
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
rr=1:size(ewh,1);
cc=1:size(ewh,2);

for k=1:n
    if length(ewh(:,:,k))>0
%         disp('存在无效值');
        tempewh=ewh(:,:,k);
        tempewh(isnan(tempewh))=0;
    end
    temp=  tempewh.*mask(rr,cc).*cwg(rr,cc);
    m=sum(mask(rr,cc) .*cwg(rr,cc),'all');
    tws(k,1)=sum(  temp ,'all')/m;
end


d=study_basin.Resolution(1);
tem_ceta=90-d/2:-d:-90+d/2;
tem_fir=-180+d/2:d:180-d/2;
s_globe=sum(cosd(tem_ceta)*length(tem_fir));


tws1=tws;
S=m*ae* ae/10^6*deg2rad(d)^2;%unit :km面积
end