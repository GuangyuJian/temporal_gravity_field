classdef sol_filter<handle

    properties
        maxn            %截断阶数
        radius_earth    %地球平均曲率半径

        Filter_Type     %滤波类型
        rn              %阶半径
        rm              %次半径
        recn            %重构次数
        wnm             %权重系数wnm

        destrip_flag    %去相关滤波标记
        PnMl_n          %拟合阶数
        PnMl_m          %PnMl开始拟合次数
        %================
        %对接冯伟老师的参数部分
        fw_destrip_type
        ddk_type double
%       fw_destrip_flag
    end
    %%
    methods
        function self=sol_filter(maxn)

            if nargin==1
                if isnumeric(maxn)&length(maxn)==1
                    if maxn==fix(maxn)% interger check
                        self.maxn=maxn;
                    else
                        error('max degree should be a interger');
                    end
                else
                    error('max degree should be a numeric number');
                end
            else
                error('we need the max degree of sphere function');
            end

            self.Filter_Type='none';
            self.rn=0;
            self.rm=0;
            self.radius_earth=6371; %(unit:km)

            self.destrip_flag=0;
            self.PnMl_n=6;
            self.PnMl_m=3;

            self.fw_destrip_type='none';

            en=1+(maxn+3)*(maxn)/2;
            wnm(1:en,1)=1;
            self.wnm=wnm;
            disp("the filter solutions is done");

        end
        %% defind the traditional filter
        self=set_filter(self,varargin);%set the filter parameter
        self=pre_destrip(self,destrip_flag,PnMl_n,PnMl_m);%our pnml method for gdut project
        self=pre_destrip_fw(self,option); %the destriping method from fengwei toolbox
        self=pre_destrip_ddk(self,option)
        %% show the filter function
        [h]=wnm_plot(self);
        [h]=wnm_imagesc(self);
        [h]=wn_plot(self);
        [h]=wn_semilogy(self);
    end
    %%
    methods(Static)
        wnm=w_fan(max_degree,rf,radius_earth);
        wnm=w_rec(wnm_basic,recn);
        wnm=w_han(max_degree,R,r0,r1,m1);
        [wnm,wn]=w_gauss(max_degree,rf,radius_earth) ;

        SH=st_PnMl(SH,nn,ll,Lmax);

        scnew = st_destriping_swenson(sc);
        scnew = st_destriping_duan(pair1,pair2,r,gamma,p,K,A,sc);
        scnew = st_destriping_chen(sc,type);
        scnew = st_destriping_chambers(sc,type);
        shc =   st_destriping(self,fw_destrip_type);

    end
end



