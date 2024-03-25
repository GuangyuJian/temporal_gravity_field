function [shc]=st_destriping(sc,fw_destrip_type)
%
%----------------------------------------------------------------------------
% In   :    sc               [maxn+1 x maxn*2+1]    shc in sc-format 
%           fw_destrip_type     char                methods of fw_toolbox
% Out  :    
%           shc               structure             shc in shc-format
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-20
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:Feng, W. (2019). "GRAMAT: a comprehensive Matlab toolbox for estimating 
% global mass variations from GRACE satellite data." 
% Earth Science Informatics 12(3): 389-404.
%**************************************************************************

switch fw_destrip_type
    case 'swenson'
        sc = sol_filter.st_destriping_swenson(sc);
    case 'chambers2007'
        sc = sol_filter.st_destriping_chambers(sc,'chambers2007');
    case 'chambers2012'
        sc = sol_filter.st_destriping_chambers(sc,'chambers2012');
    case 'chenp3m6'
        sc = sol_filter.st_destriping_chen(sc,'chenp3m6');
    case 'chenp4m6'
        sc = sol_filter.st_destriping_chen(sc,'chenp4m6');
    case 'duan'
        pair1=35;    pair2=15;    r=3.5;
        gamma=0.1;    p=2;    K=15;    A=30;
        sc = sol_filter.st_destriping_duan(pair1,pair2,r,gamma,p,K,A,sc);
    case 'none'
        sc=sc;
    otherwise
        disp(' Destrping method is wrong!');
        error( '(Options: NONE,SWENSON,CHAMBERS2007,CHAMBERS2012,CHENP3M4,CHENP4M6 and DUAN)');
end
clm = storage_cssc2clm(sc);
shc.cnm=clm(:,3);
shc.snm=clm(:,4);

end

