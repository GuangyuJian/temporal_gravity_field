% classdef sol<handle
%     
%     properties
%         %=================
%         % ��������õ�
%         Resolution          %����ķֱ���
%         fir                 %����ľ��ȵ�
%         ceta                %�����γ�ȵ�
%         grid_fir            %����ľ��ȵ�����
%         grid_ceta           %�����γ�ȵ�����
%         %=================
%         mask                %��Ĥ
%         cos_weight_grid     %���Ҽ�Ȩ����
%         %=================
%         boundary_fir        %�߽羭��
%         boundary_ceta       %�߽�γ��
%         %=================
%         %% %solution defind
%         Filter_Type         %�˲�����
%         Filter_radius_l     %�װ뾶
%         Filter_radius_m     %�ΰ뾶
%         Decor_flag          %ȥ����˲����
%         DD_polyfit_Degree   %��Ͻ���
%         DD_start_order      %PnMl��ʼ��ϴ���
%         Filter_N            %�ع�����
%         %================
%         %�Խӷ�ΰ��ʦ�Ĳ�������
%         destrip_type
%         destrip_flag
%         
%         %================
%         %rely on solution defind and resolution defind
%         M                   %����M_lm
%         Wlm                 %Ȩ��ϵ��Wlm
%         Coe_Love            %�շ���
%         Coe_P               %��ȫ����������õ�ϵ��
%         Coe_Water           %ˮϵ��
%         sind_m_fir          %����ϵ��sind_m_fir
%         cosd_m_fir          %����ϵ��cosd_m_fir
%         %====================
%         %% %fileread
%         Ins_Ver             %����汾
%         Lmax                %�ضϽ���
%         SH_Dir              %SH��ַ
%         
%         SLR_address         %SLR�ļ���ַ
%         SLR_flag            %�Ƿ��滻SLR C20
%         SLRC30_address         %SLR�ļ���ַ
%         SLRC30_flag            %�Ƿ��滻SLR C20
%         GEOC_address        %GEOC�ļ���ַ
%         GEOC_flag           %�Ƿ��滻��GEOC C10 C11 S10 S11
%         
%         SH                  %��гϵ�� ���ļ���ȡ ����г�������
%         S2E_YMD             %���ݿ��
%         R                   %����ƽ�����ʰ뾶
%         %==================
%         %% %result
%         time                %ʱ����
%         
% %         Post_ewh            %gldas/trmm�ȷ�GRACE���� ���������
% %         Post_ewh_k          %GRACE����߶����ӷ�������
% %         Post_ewh_fm         %GRACE���fm��������
% %         
% %         Post_tws;
% %         Post_tws_k          %tws �߶����ӷ�������
% %         Post_tws_fm         %tws fm��������
% %         
% %         Pre_ewh             %ԭʼ���ݷ�����
% %         Pre_sigma           %ԭʼ������������
% %         Pre_tws             %ԭʼ����_tws
%         
% %         k                   %�߶Ⱦ���
%         %=================
%         %  GLDAS
%         GLDAS
%     end
%     %%
%     methods
%         function self=Solution(Resolution,box)
%             %             default
%             
%             self.Filter_Type='None';
%             self.Filter_radius_l=0;
%             self.Filter_radius_m=0;
%             self.Decor_flag=0;
%             self.DD_polyfit_Degree=3;
%             if ~isnumeric(Resolution)
%                 Disp_Clock;
%                 error("Solution:    ���������֣�����ķֱ��ʣ�");
%             end
%             if nargin==1
%                 if Resolution==0.5||Resolution==1||Resolution==0.125||Resolution==0.25
%                     
%                     d=Resolution;
%                     self.ceta=90-d/2:-d:-90+d/2;
%                     self.fir=-180+d/2:d:180-d/2;
%                     [self.grid_fir,self.grid_ceta]=meshgrid(self.fir,self.ceta);
%                 else
%                     Disp_Clock;
%                     error("Solution:    ȫ��Resolutionѡ��ֻ��0.1 ��0.25 ��0.125�� 0.5��1");
%                 end
%             elseif nargin==2
%                     d=Resolution;
% %                     box [fmin,fmax,cmin,cmax]
% 
%                     self.ceta=box(4)-d/2:-d:box(3)+d/2;
%                     self.fir=box(1)+d/2:d:box(2)-d/2;
%                     [self.grid_fir,self.grid_ceta]=meshgrid(self.fir,self.ceta);
% 
%             end
%             self.Resolution=Resolution;
%             Disp_Clock;
%             disp("������������ɹ�");
%             disp('�ֱ���Ϊ');
%             disp(Resolution);
%         end
%         
%         
%         function set.Ins_Ver(obj,Ins_Ver)
%             obj.Ins_Ver=Ins_Ver;
%         end
%         
%         function  set.SH_Dir(obj,SH_Dir)
%             obj.SH_Dir=SH_Dir;
%         end
%         
%         function  set.SLR_address(obj,SLR_address)
%             obj.SLR_address=SLR_address;
%             obj.SLR_flag=1;
%         end
%         
%         function  set.GEOC_address(obj,GEOC_address)
%             obj.GEOC_address=GEOC_address;
%             obj.GEOC_flag=1;
%         end
%         
%         function  set.Lmax(self,Lmax)
%             self.Lmax=Lmax;
%         end
%         
%         function  set.R(self,R)
%             self.R=R;
%         end
%     set_Resolution_full_band(self,Resolution,box)
%         self=set_single(self,fir,ceta);
%         set_GLDAS(self,GLDAS_Type,GLDAS_Path)
%         set_fir_ceta(self,fir,ceta);
%         set_Resolution(self,Resolution,box);
%         set_Resolution2(self,Resolution,box);
%         set_box(self,Resolution);
%         %======================================
%         %%
%         %       ��ȡ���ݷ���                  %
%         %         Ins_Ver       SH_Dir
%         %         Lmax          R
%         %         SLR_address   SLR_flag
%         %         GEOC_address  GEOC_flag
%         %         SH            S2E_YMD
% Read_SH_DDK_GRACE(self);
% 
%         Read_SH_LEO(self);    %��ȡLEO��Ϣ
%         Read_SH_GRACE(self);    %��ȡGRACE��Ϣ
%         Read_SH_SWARM(self);    %��ȡSWARM��Ϣ
%         Read_SH_L1(self);       %��ȡGEOCһ��
%         Read_SH_C20(self);      %��ȡSLR C20
%         Read_SH_C30(self);       %��ȡSLR C20
%         %========================================
%         %%
%         %               �������趨                  %
%         %                Filter_Type
%         %   Filter_radius_l   Filter_radius_m
%         %                PnMl
%         %   Decor_flag        DD_polyfit_Degree
% %         pre_filter(self,Filter_Type,Filter_radius_l,Filter_radius_m);%�˲������趨
%         pre_destrip(self,Decor_flag,DD_polyfit_Degree,DD_start_order);%ȥ��ز����趨
%         pre_destriping(self,option);
%         %=======================================
%         %%
%         %               ����ϵ������                   %
%         get_Coe(self,varargin);%�������ϵ��
%         set_filter(self,varargin); %�������ϵ��20230608��ӵ��°汾
%         %         SH2EWH(self,varout_par);%����ewh�����
%         %=======================================
%         %%
%         %           ��ͼ�������趨��չʾ�о�����       %
%         get_mask(self,boundary_fir1,boundary_ceta1,boundary_fir2,boundary_ceta2);%�趨�о�����
%         plot_region(self,type)%չʾ�о�����
%         %=======================================
%     end
% end
% 
% 
