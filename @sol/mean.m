function obj2 = mean(objv,dim)
% mean(objv,1)
% mean(obj2,2)
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

if length(dim)==1
    obj2=sum(objv,dim);
    nsol2=length(obj2);
    nsol=length(objv);
    ntime=length(objv(1).time);
    if dim==1
        nn=ntime;
    elseif dim==2
        nn=nsol;
    end

    switch class(obj2)
        case {'sol_sf','sol_ts'}
            for k=1:nsol2
                obj2(k).value=obj2(k).value/nn;
            end
        case 'sol_shc'
            for k=1:nsol2
                shct= obj2(k).storage;
                [sht]=storage_shct2sht(shct) ;
                shtm=sht/nn;
                shct=storage_sht2shct(shtm);
                obj2(k).storage=shct;
            end
    end

elseif length(dim)==2

    obj2 = mean(objv,dim(2));
    obj2 = mean(obj2,dim(1));

end

end

