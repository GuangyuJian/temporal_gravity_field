function [ym_char,ym_flag]=check_ym(self,tt)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

if ~isempty(self.time)
    ym_flag=1;
    iy=self.int_year(tt);
    im=self.int_month(tt);

    if im<10
        ym_char=([num2str(iy) '-0' num2str(im) ]);
    else
        ym_char=([num2str(iy) '-' num2str(im) ]);
    end

else
    ym_flag=0;
end



end

