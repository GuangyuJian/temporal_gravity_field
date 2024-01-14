function [bg]=bg_ggm05c()

path='GGM05C.txt';

[ ~,~ ,  ~,c, s, ~, ~  ]=textread(path,'%s %f %f %f %f %f %f %*f');

shc_bg.cnm=c;
shc_bg.snm=s;

bg=sol_shc(shc_bg,60,'shc','gc');
end