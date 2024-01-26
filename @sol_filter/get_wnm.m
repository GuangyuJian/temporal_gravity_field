function self=get_wnm(self)
% usage:self=get_wnm(self)
%**************************************************************************
% In   : 
%       self        @sol_filter
% Out  :    
%       self.wnm is changed 
%       wnm         [(Nmax+2)*(Nmax+1)/2 x 1]   
%                   weighted coefficients storaged as clm-format                                   
%--------------------------------------------------------------------------

% Authors: Karl Jian
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************

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
        wnm=sol_filter.w_gauss(maxn,rn,radius_earth); %类内静态函数调用的方法class_name.static_methods

    case "fan"
        if rn~=rm
            error('wrong: fan radius should be the same');
        end
        wnm=sol_filter.w_fan(maxn,(rn+rm)/2,radius_earth);

    case "recgauss"
        wnm=sol_filter.w_gauss(maxn,rn,radius_earth);
        wnm=sol_filter.w_rec(wnm,recn);

    case "recfan"
        if rn~=rm
            error('wrong: fan radius should be the same');
        end
        wnm=sol_filter.w_fan(maxn,(rn+rm)/2,radius_earth);
        wnm=sol_filter.w_rec(wnm,recn);
    case 'han'
        wnm=sol_filter.w_han(maxn,radius_earth);

    otherwise
        en=1+(maxn+3)*(maxn)/2;
        wnm(1:en,1)=1;
        disp('we use none_filter solutions');

end
self.wnm=wnm;

show_time_tag;
disp('sol_filter:——>get_wnm:  weight function is storaging');

end