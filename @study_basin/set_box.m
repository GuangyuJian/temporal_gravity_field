function set_box(self,Resolution)

d=Resolution;
self.Resolution=d;
self.set_Resolution(d);
blx=self.boundary_fir;
bly=self.boundary_ceta;
[rl,cl]=get_bl_box_self(self,blx,bly);
box=[ self.fir(cl(1))-d/2 self.fir(cl(2))+d/2+0 self.ceta(rl(2))-d/2 self.ceta(rl(1))+d/2];
self.set_Resolution(d,box);
self.get_mask(blx,bly);
self.get_Coe({'only_coe'});
end

function [rl,cl]=get_bl_box_self(Sol,blx,bly)

mbx=max(blx);
mby=max(bly);

mibx=min(blx);
miby=min(bly);

ceta=  Sol.ceta;
fir=    Sol.fir;
 rm=min(ceta(find(ceta>=mby)));
 rmi=max(ceta(find(ceta<miby)));
 cmi=max(fir(find(fir<mibx)));
 cm=min(fir(find(fir>=mbx)));

rm= find(rm==ceta);
 rmi=find(rmi==ceta);
 cm=find(cm==fir);
 cmi=find(cmi==fir);
 rl=[rm rmi];
 cl=[cmi cm];
end