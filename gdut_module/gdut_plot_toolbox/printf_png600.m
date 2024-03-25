function printf_png600(name,f)
% 该函数输出PNG格式dpi600的图片

if nargin==1


exportgraphics(gcf,[name '.png'],'Resolution','600');
    disp('已经输出当前句柄图像figure');
    disp('format: -dpng -r600')
end

if nargin==2
    
    disp('已经输出指定句柄】图像figure');
    disp('format: -dpng -r600')
exportgraphics(f,[name '.png'],'Resolution','600');
end
disp('已经保留在当前路径');
end