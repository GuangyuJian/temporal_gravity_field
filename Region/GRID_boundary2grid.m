
function[mask,cos_weight_grid]=GRID_boundary2grid(M_fir,M_ceta,boundary_fir1,boundary_ceta1,boundary_fir2,boundary_ceta2)
% 该函数将输入的边界信息转换为所需的格网
%input：
%boundary_ceta&boundary_fir 为边界经纬向量
% （%boundary 需要为闭合shp）
%delta为所需游程大小
%ouput
%mask为区域蒙版，1为区域内，0为区域外的矩阵
%cos_weight为纬度余弦权阵
%fir,ceta为格网经纬向量
%x,y为格网经纬矩阵
% temp_ceta=boundary_ceta;
% temp_fir=boundary_fir;
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
    mask=inpolygon(x,y,boundary_fir1,boundary_ceta1);
    temp=repmat(cosd(ceta)',[size(fir)]);
%     cos_weight_grid=temp.*mask/sum(temp.*mask,"all");
    cos_weight_grid=temp;%.*mask/sum(temp.*mask,"all");
elseif nargin==6
    mask1=inpolygon(x,y,boundary_fir1,boundary_ceta1);
    mask2=inpolygon(x,y,boundary_fir2,boundary_ceta2);
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

