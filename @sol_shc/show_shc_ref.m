function [h]=show_shc_ref(obj1,obj2)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-03-30
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
obj1.change_type('gc');
obj2.change_type('gc');
maxn=obj1.maxn;
[clm]=storage_shc2clm(obj1.storage(:,:,1),maxn);        
[sc]=storage_clm2sc(clm, maxn);

[clm]=storage_shc2clm(obj2.storage(:,:,1),maxn);        
[sc2]=storage_clm2sc(clm, maxn);

% sc./sc2;
sc(sc==0)=nan;
sc=log10(abs(sc))-log10(abs(sc2));

h=imagesc(-maxn:1:maxn,0:maxn,sc,[-3 3]);
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




caxis([-3 3])


end
