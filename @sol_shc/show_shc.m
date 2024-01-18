function [h]=show_shc(self,tt)
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
% date: 2024-01-17
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
maxn=self.maxn;
tempc=self.storage(tt).cnm;
temps=self.storage(tt).cnm;

f=0;
for n=0:maxn
    for m=0:n
        f=f+1;
        nn(f,1)=n;
        mm(f,1)=m;
    end
end
clm=[nn mm tempc temps];




[sc]=storage_clm2sc(clm, maxn);

sc(sc==0)=nan;
sc=log10(abs(sc));
h=imagesc(-maxn:1:maxn,0:maxn,sc);
xticks([-maxn:20:maxn]);
xticklabels({-maxn:20:maxn});

set(gca,'FontSize',12)
set(h,'alphadata',~isnan(sc));
ylabel('Degree (n)');
xlabel('C<——Order (m)——>S');
colormap(jet);
colorbar;
% caxis ([0 1])
grid on;

if ~isempty(self.time)
iy=self.int_year(tt);
im=self.int_month(tt);

if im<10
titlestr=([num2str(iy) '-0' num2str(im) ]);
else
titlestr=([num2str(iy) '-' num2str(im) ]);
end
title(titlestr);
end




end

