%Decentre-Decorrelation filtering
function[SH]=math_PnMl(SH,nn,ll,Lmax)


%  correct :20230317 poly degree is equal the fit number 
SHtemp(1:1:1+(Lmax+3)*(Lmax)/2,1)=0;


% defval('nn',3);
% defval('ll',6);
lowm=ll;
upm=Lmax-10;

temp=zeros(Lmax+1);
for l=0:Lmax
    st=2+(l+2)*(l-1)/2;
    en=st+l;
    temp(1:l+1,l+1)=SH(st:en,1);
end

for m=lowm:upm
    %     if m<=lown
    %         ms=lown;
    %         l1=ms+1:2:Lmax;
    %         l2=ms+2:2:Lmax;
    %         p1=polyfit(l1,temp(m+1,l1+1),nn);
    %         p2=polyfit(l2,temp(m+1,l2+1),nn);
    %     end
    % %         location
    %     if m>lown
    %         ms=m;
    %         l1=ms:2:Lmax;
    %         l2=ms+1:2:Lmax;
    %         p1=polyfit(l1,temp(ms+1,l1+1),
    % nn);
    %         p2=polyfit(l2,temp(ms+1,l2+1),nn);
    %     end
    
    ls=m;
    
    l1=ls:2:Lmax;
    l2=ls+1:2:Lmax;
    
    lm1=2+(l1+2).*(l1-1)/2+m;
    lm2=2+(l2+2).*(l2-1)/2+m;
    
    
    p1=polyfit(l1,temp(m+1,l1+1),nn);
    p2=polyfit(l2,temp(m+1,l2+1),nn);
    if length(l1)>nn+1
        SHtemp(lm1)= polyval(p1,l1);
        
    else
        SHtemp(lm1)= 0;
    end
    
    if length(l2)>nn+1
        SHtemp(lm2)= polyval(p2,l2);
    else
        SHtemp(lm2)= 0;
    end
    
end

% lc=find(SH~=0&SHtemp~=0);
% temp1=SHtemp(lc);
% temp2=SH(lc)-SHtemp(lc);
% scatter(temp1,temp2)
% corrcoef(temp1,temp2)
SH=SH-SHtemp;

end