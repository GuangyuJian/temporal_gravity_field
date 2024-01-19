function [h]=wnm_imagesc(self)
%   usage: self.wnm_imagesc
%   plot the weight function in sc format
%----------------------------------------------------------------------------
% In   :
%       self    (1x1)  @sol_filter
% Out  :
%       h       (1x1)   @handle of plot
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-24
% MATLAB_version: 9.12.0.1884302 (R2022a)
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
[sc]=storage_clm2sc(clm, maxn);

sc((sc==0))=nan;
% figure;

h=imagesc(-maxn:1:maxn,0:maxn,sc);

set(gca,'FontSize',12)
set(h,'alphadata',~isnan(sc));
ylabel('Degree (n)');
xlabel('C<——Order (m)——>S');
colormap(jet);
colorbar;
caxis ([0 1])
grid on;

end

