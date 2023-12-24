classdef sol_filter<handle

    properties
        maxn            %�ضϽ���
        radius_earth    %����ƽ�����ʰ뾶

        Filter_Type     %�˲�����
        rn              %�װ뾶
        rm              %�ΰ뾶
        recn            %�ع�����
        wnm             %Ȩ��ϵ��Wlm

        PnMl_flag       %ȥ����˲����
        PnMl_n          %��Ͻ���
        PnMl_m          %PnMl��ʼ��ϴ���
        %================
        %�Խӷ�ΰ��ʦ�Ĳ�������
        fw_destrip_type
        fw_destrip_flag
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

            self.PnMl_flag=0;
            self.PnMl_n=6;
            self.PnMl_m=3;

            self.fw_destrip_flag=0;
            self.fw_destrip_type='NONE';
            
            en=1+(maxn+3)*(maxn)/2;
            wnm(1:en,1)=1;
            self.wnm=wnm;
            disp("the filter solutions is done");

        end
        %% defind the traditional filter 
        set_filter(self,varargin);%set the filter parameter
        pre_destrip(self,PnMl_flag,PnMl_n,PnMl_m);%our pnml method for gdut project
        pre_destriping(self,option); %the destriping method from fengwei toolbox
        %% plot the filter function
        wnm_plot(self);
        wnm_imagesc(self);
    end
end


