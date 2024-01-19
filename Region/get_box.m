function [x,y]= get_box(mat)


left=mat(1);
down=mat(3);
weight=mat(2);
height=mat(4);

x=[left left+weight left+weight left left];
y=[down down down+height down+height  down];


end