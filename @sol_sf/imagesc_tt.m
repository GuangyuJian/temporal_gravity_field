function [h]=imagesc_tt(self,varargin)
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
% date: 2023-12-29
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

fir=self.fir;
ceta=self.ceta;

switch length(varargin)

    case 1
        tt=varargin{1};
    case 3

        if strcmp(varargin{1},'ym')
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



if isempty(tt)
    error('target sf is not here')
end
h=imagesc(fir,ceta,self.value(:,:,tt));
% set(h,'alphadata',~isnan(self.value(:,:,tt)));
% [h]=set_nan_h(h,self.value(:,:,tt)) ;
set(h,'alphadata',~isnan(self.value(:,:,tt)));        
set(gca,'FontSize',12);
axis xy;

c=colorbar('eastoutside');
c.Label.String=self.unit;

colormap("jet");

if ~isempty(self.time)
    iy=self.int_year(tt);
    im=self.int_month(tt);

    if im<10
        titlestr=([num2str(iy) '0' num2str(im) ]);
    else
        titlestr=([num2str(iy) num2str(im) ]);
    end
    title(titlestr);
end
xlabel('经度（°）');
ylabel('纬度（°）');
grid on;
box on;
end

