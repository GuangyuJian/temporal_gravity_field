function self=get_wnm(self)
maxn=self.maxn;
radius_earth=self.radius_earth;
rn=self.rn;
rm=self.rm;
recn=self.recn;

if isempty(self.Filter_Type)
    self.Filter_Type='none';
end

switch self.Filter_Type
    case "none"
        en=1+(maxn+3)*(maxn)/2;
        wnm(1:en,1)=1;

    case "gauss"
        wnm=sh_filter_gauss(maxn,rn,radius_earth);

    case "fan"
        if rn~=rm
            error('wrong: fan radius should be the same');
        end
        wnm=sh_filter_fan(maxn,(rn+rm)/2,radius_earth);

    case "recgauss"
        wnm=sh_filter_gauss(maxn,rn,radius_earth);
        wnm=sh_filter_rec(wnm,recn);

    case "recfan"
        if rn~=rm
            error('wrong: fan radius should be the same');
        end
        wnm=sh_filter_fan(maxn,(rn+rm)/2,radius_earth);
        wnm=sh_filter_rec(wnm,recn);
    case 'han'
        wnm=sh_filter_han(maxn,radius_earth);

    otherwise
        en=1+(maxn+3)*(maxn)/2;
        wnm(1:en,1)=1;
        disp('we use none_filter solutions');

end
self.wnm=wnm;

show_time_tag;
disp('sol_filter:——>get_wnm:  weight function is storaging');

end