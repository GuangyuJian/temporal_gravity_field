function[Coe_P]=math_NormLegendre(Lmax,x)
%==============================================
%Input
%     Lmax:��߽���
%     x    :γ�ȶ�Ӧ����ά�ȵ�����ֵ
%Ouput
%     Coe_P:��ȫ��񻯵����õ�ϵ��
%===============================================
k=length(x);
% Pnm=zeros(Lmax+1);
if size(x,1)~=1
   x=x'; 
end
% if Lmax>200
%     h=waitbar(0,'���ڼ������õº���');
% end
for l=0:Lmax
    p=legendre(l,x,'norm');%��һ���������õ�ϵ��
    st=2+(l+2)*(l-1)/2;
    en=st+l;
    %��ȫ��񻯴���;
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