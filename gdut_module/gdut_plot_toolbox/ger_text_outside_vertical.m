function []=ger_text_outside_vertical(str,fs,x,y)

if nargin==0
error('ger_text_outside_vertical(str,fs,x,y)');
end

if nargin==3
error('ger_text_outside_vertical(str,fs,x,y)');
end

if nargin==2
x=-0.25-0.06+0.1;
y=0.5;
end

if nargin==1
x=-0.25-0.06+0.12;
y=0.5;
fs=15;
end

   text(x,y,str,'FontSize',fs,...
        'FontWeight','Bold',...
        'Color',[0 0 0],...
        'Units','normalized',...
        'BackgroundColor','NONE',...
        'Rotation',90,'HorizontalAlignment','center');

end