function [ewhvmd,ewhvecr,ewhvecr_mode,info] =vmd_grace_mass_field_wk(ewh,maxnum,PenaltyFactor)

% Input :
% ewh:		matrix (r,c,K)	original observation
% maxnum（K）	int		total number of mode
%PenaltyFactor 	（\alpha）	Penaty factor in VMD algorithm	
%
% Output:
% ewhvmd :	matrix (r,c,K)	 records 2-d results of each mode
% ewhvecr : 	matrix (r*c) 	records 1-d sequence of ewh
% ewhvecr_mode:	matrix (r*c,K) 	records 1-d sequences of ewhvmd 
%
% Editor: 		Guangyu Jian
% Contact: 	gyjian@mail2.gdut.edu.cn 
% please let me know if you confuse about our code
% it is a code for filtering north-south stripe noise
% 
% Date: 2023 10 18
% Reference: 
% Unveiling North-South Stripe Patterns in the GRACE Gravity Field using Dimensionality Reduction
% under review
%
% record the number of element along each row or column

r=size(ewh,1); 
c=size(ewh,2);
tt=size(ewh,3);

if tt~=1
   error('more than one month'); 
end


d=180/r;
ceta=90-d/2:-d:-90+d/2;


% compute weight matrix
f=0;
for ce=90-ceta
    f=f+1;
    sum1=0;
    for k=0:r/2-1
        sum1=sum1+sind((2*k+1)*ce)/(2*k+1);
    end
    ds(f,1:c)=4*pi/(r^2)*sind(ce)*sum1;
end
% ds=1;


% dimensionality reduction
ewhvecr=mat2vecr(ewh.*ds);
    
% decomposition
    [mra,res,info]=vmd(ewhvecr,'NumIMF',maxnum,'PenaltyFactor',PenaltyFactor);

% decomposition
% record each mode 
for k=1:maxnum


     [temp]=mra(:,k); 
    ewhvecr_mode(:,k)=temp; %record each mode 
% dimensionality recover
    [mat]=vecr2mat(temp,r,c); 
    ewhvmd(:,:,maxnum+1-k+1)=mat./ds; 

   %
    %     imagesc(mat,[-300 300])
end

% record residual
k=k+1;
ewhvecr_mode(:,k)=res;
[res]=vecr2mat(res,r,c);
ewhvmd(:,:,maxnum+1-k+1)=res./ds;

% check the residual 
res=rms(rms(res));
disp(res)

end