
function[mask,cos_weight_grid]=GRID_boundary2grid(M_fir,M_ceta,bf1,bc1,bf2,bc2)
% �ú���������ı߽���Ϣת��Ϊ����ĸ���
%input��
%bc&bf Ϊ�߽羭γ����
% ��%boundary ��ҪΪ�պ�shp��
%deltaΪ�����γ̴�С
%ouput
%maskΪ�����ɰ棬1Ϊ�����ڣ�0Ϊ������ľ���
%cos_weightΪγ������Ȩ��
%fir,cetaΪ������γ����
%x,yΪ������γ����
% temp_ceta=bc;
% temp_fir=bf;
%
% cmax=max(temp_ceta);
% fmax=max(temp_fir);
%
% cmin=min(temp_ceta);
% fmin=min(temp_fir);
%
% fir=fmin:delta:fmax;
% ceta=cmin:delta:cmax;
%
fir=M_fir;
ceta=M_ceta;

if ~isrow(fir)
error('longititude vector is not row vector');
end

if ~isrow(ceta)
error('latitude vector is not row vector');
end
fir=fir(:)';
ceta=ceta(:)';



[x,y]=meshgrid(M_fir,M_ceta);
if nargin==4
    mask=inpolygon(x,y,bf1,bc1);
    temp=repmat(cosd(ceta)',[size(fir)]);
%     cos_weight_grid=temp.*mask/sum(temp.*mask,"all");
    cos_weight_grid=temp;%.*mask/sum(temp.*mask,"all");
elseif nargin==6
    mask1=inpolygon(x,y,bf1,bc1);
    mask2=inpolygon(x,y,bf2,bc2);
    mask=mask1-mask2;
    temp=repmat(cosd(ceta)',[size(fir)]);
%     cos_weight_grid=temp.*mask/sum(temp.*mask,"all");
    cos_weight_grid=temp;%.*mask/sum(temp.*mask,"all");
end
%

%

% all=sum(temp.*mask,"all");
end


%

