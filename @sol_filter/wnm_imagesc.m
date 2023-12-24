function []=wnm_imagesc(self)
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
% date: 2023-12-24
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

wnm=self.wnm;
maxn=self.maxn;

f=0;
for n=0:maxn
    for m=0:n
        f=f+1;
        nn(f,1)=n;
        mm(f,1)=m;
    end
end
clm=[nn mm wnm wnm];
% plot(wnm);
[temp,maxGOout,stdsc]=storage_clm2sc(clm,'max_lm', maxn);

temp((temp==0))=nan;
% figure;

h=imagesc(-maxn:1:maxn,0:maxn,temp);

set(gca,'FontSize',12)
set(h,'alphadata',~isnan(temp));
ylabel('Degree (n)');
xlabel('C<——Order (m)——>S');
colormap(jet);
colorbar;
caxis ([0 1])
grid on;

end

