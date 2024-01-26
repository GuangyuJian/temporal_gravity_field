function [tws1,S]=grid2rms(grid,study_basin)                             
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
                              
 ewh=grid;
ae        =  6378136.3;
mask=study_basin.mask;
cwg=study_basin.cos_weight_grid;
n=size(ewh,3);
tws=zeros(n,1);

if size(ewh,1)~=size(mask,1)|size(ewh,2)~=size(mask,2)
    Disp_Clock;
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
    temp=  ewh(:,:,k)    .*mask(rr,cc)  ;
    m=sum(mask(rr,cc) .*cwg(rr,cc),'all');
    w=mask(rr,cc).*cwg(rr,cc)/m;


    loc=find(temp~=0);
    w=w(loc);
    temp=temp(loc).^2;
    tws(k,1)=sqrt(sum(temp.*w,'all'));
%     tws(k,1)=sqrt(sum(  temp ,'all')/m);
end


d=study_basin.Resolution(1);
tem_ceta=90-d/2:-d:-90+d/2;
tem_fir=-180+d/2:d:180-d/2;
s_globe=sum(cosd(tem_ceta)*length(tem_fir));


tws1=tws;
S=m*ae* ae/10^6*deg2rad(d)^2;%unit :km面积                             
                              
                              
end

