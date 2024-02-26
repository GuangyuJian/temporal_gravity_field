function [time,int_year,int_month]=gdut_uniform_time(trange)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-02-02
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
switch class(trange)

    case 'double'
        if length(trange)~=4
            error('worng input: trange');
        else
            iy1=trange(1);
            iy2=trange(3);
            im1=trange(2);
            im2=trange(4);
            if iy1>iy2
                error('start year>end year');
            elseif iy1==iy2
                if im1>=im2
                    error('start month>=end month');
                end
            end
        end

    otherwise
        error(['wrong type： trange—' class(trange)]);
end


ik=0;
for iy=iy1:iy2
    for im=1:12
        ik=ik+1;
        int_year(ik)=iy;
        int_month(ik)=im;
        time(ik)=iy+(im-0.5)/12;
    end
end

time=time(im1:end-12+im2);
int_year=int_year(im1:end-12+im2);
int_month=int_month(im1:end-12+im2);
end

