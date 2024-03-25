function [h]=ger_text_outside_horizontal(str,fs,x,y)

if nargin==0
error('ger_text_outside_horizontal(str,fs,x,y)');
end


if nargin==3
error('ger_text_outside_horizontal(str,fs,x,y)');
end

if nargin==2
x=0.5;
y=1.1;
end


if nargin==1
x=0.5;
y=1.1;
fs=15;
end

   h=text(x,y,str,...
       'FontUnits','points','FontSize',fs,...
        'FontWeight','normal',...
        'Color',[0 0 0],...
        'Units','normalized',...
        'BackgroundColor','NONE',...
        'Rotation',0,'HorizontalAlignment','center');
%     h.FontUnits="points";
%     h.FontSize=fs;
    
end