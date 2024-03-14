function [grid]= fit_harmonic_sf_mask(t1,ewh,mask)

t1=t1(~isnan(t1));

grid=zeros(size(ewh,1),size(ewh,2),5);


for r=1:size(ewh,1)
    for c=1:size(ewh,2)
    if mask(r,c)==1

        mat=ewh(r,c,:);
        if mat(1,1,1)~=0
            [info]=fit_harmonic_ts(t1(:),mat(:),t1);
            grid(r,c,:)=info(:,1);
        else
               grid(r,c,1:5)=0;
        end
    else 
         grid(r,c,1:5)=nan;
    end
         
    end
end

end