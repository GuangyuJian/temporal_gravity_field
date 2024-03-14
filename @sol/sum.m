function[objv2]=sum(objv,lc)

objv2=objv(1)-objv(1);
if nargin==1

for k=1:length(objv)
    objv2=objv2+objv(k);
end

elseif nargin==2

for k=1:length(lc)
    objv2=objv2+objv(lc(k));
end  

end
end