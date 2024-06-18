function [h]=show_shc_sigma(self,varargin)                               
% h=show_shc(self,tt)
% h=self.show_shc(tt)
% show the sigma of shc for a given time index (tt) in sc-format 
%----------------------------------------------------------------------------
% In   : self   [1x1]  @sol_shc    
%        tt     [1x1]   time index
% 
% Out  : h      [1x1]   @handle of plot
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-23
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
if nargin>1

    switch length(varargin)
        case 1
            %  self.imagesc_tt(int_location);
            tt=varargin{1};
        case 3
            % self.imagesc_tt('ym',int_year,int_month); recommend!
            % self.imagesc_tt('one',int_year,int_month); recommend!
            if strcmp(varargin{1},'ym')||strcmp(varargin{1},'one')
                iy=varargin{2};
                im=varargin{3};
                lm1=(self.int_month==im);
                ly1=(self.int_year==iy);
                tt=find(lm1.*ly1==1);
            else
                error('! wrong argument ');
            end
        otherwise
            error('wrong input');
    end

elseif nargin==1
    disp('show the first one');
    tt=1;
end

if isempty(tt)
    disp([num2str(iy) '-' num2str(im) 'is missing']);
    error('target sf is not here')
end


maxn=self.maxn;
tempc=self.shc_sigma(tt).cnm_sigma;
temps=self.shc_sigma(tt).snm_sigma;

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
sc=log10((sc));
h=imagesc(-maxn:1:maxn,0:maxn,sc);
% set(gca,'FontSize',10,'units','points')
set(gca,'FontSize',10,'FontUnits','points')


xticks([-maxn:20:maxn]);
xticklabels({-maxn:20:maxn});

set(h,'alphadata',~isnan(sc));
ylabel('Degree (n)');
xlabel('S<——Order (m)——>C');
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

