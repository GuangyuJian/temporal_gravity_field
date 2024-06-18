function [scrms,scrms2]=show_shc_rms(self)
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
% date: 2024-04-28
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
ntime=self.time;
for tt=1:length(ntime)
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
    [sc(:,:,tt)]=storage_clm2sc(clm, maxn);

    sc(sc==0)=nan;
%     sc=log10(abs(sc));

end
scrms2=rms(sc,3);
scrms=log10(abs(scrms2));
 scrms(scrms==0)=nan;


h=imagesc(-maxn:1:maxn,0:maxn,scrms);
xticks([-maxn:20:maxn]);
xticklabels({-maxn:20:maxn});

set(gca,'FontSize',12)
set(h,'alphadata',~isnan(scrms));
ylabel('Degree (n)');
xlabel('S<——Order (m)——>C');
colormap(jet);
colorbar;
% caxis ([0 1])
grid on;

end
