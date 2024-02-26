function []=obs2map_fs12(ewh,value,range,titlename)
if nargin==4
    disp('画图')
end
if nargin<4
    titlename=[];
end
if nargin<3
    range='global';
end

if nargin<2
    value=[-10 10];
end

if nargin<1
    error('!');
end
d=180/size(ewh,1);

% if isempty(range)
% defval('range',[-180 180 -90 90]);
% end
if ischar(range)||isstring(range)
    switch range

        case 'global'
%             range=[-179.5 179.5 -89.5 89.5];
            range=[-180+d/2 180-d/2 -90+d/2 90-d/2];
            rangef='global'
    end
end
fs=12;

% d=1;
% d=180/size(ewh,1);
lon=[-180-d/2+d :d:-d+180+d/2];
lat=[90-d/2 :-d: -90+d/2];


lonl=[range(1)-d/2 range(2)+d/2];
latl=[range(3)-d/2 range(4)+d/2];

% lonl=[-180-d/2+d -d+180+d/2];
% latl=[-90-d/2+d -d+90-d/2];

% m_proj('miller','long',lonl,'lat',latl);

m_proj('Equidistant Cylindrical','long',lonl,'lat',latl);


% m_proj('Equidistant Cylindrical','long',lonl,'lat',latl);


lc1=find(lon>=lonl(1)&lon<=lonl(2));
lc2=find(lat>=latl(1)&lat<=latl(2));

[Plg,Plt]=meshgrid(lon(lc1),lat(lc2));
s=lc1(1):lc1(end);
e=lc2(1):lc2(end);
ewh(find(ewh==0))=nan;
m=m_pcolor(Plg,Plt,ewh(lc2,lc1));
% m_contourf(Plg,Plt,ewh(lc2,lc1),[value(1):1:value(end)],'linestyle','none','levelstep',.1);% 陆地高程

shading flat;

hold on;
color=[0.00,0.45,0.74];
m_coast('LineWidth',1,'color',[0 0 0]);
%%

caxis(value)
shading flat;
if strcmp(range,'global')
    m_grid('box','on',...
        'tickdir','in',...   'linestyle','none',...
        'FontSize',fs,'FontWeight','Bold', ...
        'ytick',[-90 -60 -30 0 30 60 90],...
        'Xtick',5,...
        'FontName', 'Helvetica',...
        'xlabeldir','middle',...
        'backcolor',[.2 .65 1]);
else
    m_grid('box','on',...
        'tickdir','in',...   'linestyle','none',...
        'FontSize',fs,'FontWeight','Bold', ...
        'ytick',4,...%     'ytick',[53 43 33],...
        'xtick',4,...%     'Xtick',[-105 -90 -80 -65],...
        'FontName', 'Helvetica',...
        'xlabeldir','middle',...
        'backcolor',[.2 .65 1]);

end

% p=get(ax11,'OuterPosition');
m_legend;
% m_gshhs_i
m_gshhs_i('color','k');
% title(titlename);

% plot_global_country_shape();

% set(gcf,'GraphicsSmoothing','on');
% set(gca,'FontSize',20,'FontWeight','Bold','FontName', 'Helvetica');
% ger_text_gca_pixels(gca,titlename,fs,[0 0 0]);
if ~isempty(titlename)
    title(titlename);
%     ger_text_gca_pixels_white_background_black_font(gca,titlename,fs);
    % text(0.024,0.996,titlename,'FontSize',fs,...
    %     'FontWeight','Bold',...
    %     'Color',[0 0 0],...
    %     'Units','normalized',...
    %     'BackgroundColor',[1 1 1]);
end
colormap(jet)
end