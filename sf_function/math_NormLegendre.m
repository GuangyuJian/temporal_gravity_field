function[Coe_P]=math_NormLegendre(Lmax,x)
%==============================================
%Input
%     Lmax:最高阶数
%     x    :纬度对应的余维度的余弦值
%Ouput
%     Coe_P:完全规格化的勒让德系数
%===============================================
k=length(x);
% Pnm=zeros(Lmax+1);
if size(x,1)~=1
   x=x'; 
end
% if Lmax>200
%     h=waitbar(0,'正在加载勒让德函数');
% end
for l=0:Lmax
    p=legendre(l,x,'norm');%归一化连带勒让德系数
    st=2+(l+2)*(l-1)/2;
    en=st+l;
    %完全规格化处理;
    if l==0
        m(1,1:k)=sqrt(2);
    else
        m(1,1:k)=sqrt(2);
        m(2:l+1,1:k)=2;
    end

    Coe_P(st:en,:)=p.*m;
%     plm(l+1,1:l+1)=p.*m;
%     if Lmax>200
%         waitbar((l+1)/(Lmax+1),h);
%     end
    
end


end