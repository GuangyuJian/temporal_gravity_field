% classdef sol<handle
%     
%     properties
%         %=================
%         % 参与计算用的
%         Resolution          %计算的分辨率
%         fir                 %计算的经度点
%         ceta                %计算的纬度点
%         grid_fir            %计算的经度点网格
%         grid_ceta           %计算的纬度点网格
%         %=================
%         mask                %掩膜
%         cos_weight_grid     %余弦加权矩阵
%         %=================
%         boundary_fir        %边界经度
%         boundary_ceta       %边界纬度
%         %=================
%         %% %solution defind
%         Filter_Type         %滤波类型
%         Filter_radius_l     %阶半径
%         Filter_radius_m     %次半径
%         Decor_flag          %去相关滤波标记
%         DD_polyfit_Degree   %拟合阶数
%         DD_start_order      %PnMl开始拟合次数
%         Filter_N            %重构次数
%         %================
%         %对接冯伟老师的参数部分
%         destrip_type
%         destrip_flag
%         
%         %================
%         %rely on solution defind and resolution defind
%         M                   %次数M_lm
%         Wlm                 %权重系数Wlm
%         Coe_Love            %勒夫数
%         Coe_P               %完全规格化连带勒让德系数
%         Coe_Water           %水系数
%         sind_m_fir          %三角系数sind_m_fir
%         cosd_m_fir          %三角系数cosd_m_fir
%         %====================
%         %% %fileread
%         Ins_Ver             %解算版本
%         Lmax                %截断阶数
%         SH_Dir              %SH地址
%         
%         SLR_address         %SLR文件地址
%         SLR_flag            %是否替换SLR C20
%         SLRC30_address         %SLR文件地址
%         SLRC30_flag            %是否替换SLR C20
%         GEOC_address        %GEOC文件地址
%         GEOC_flag           %是否替换了GEOC C10 C11 S10 S11
%         
%         SH                  %球谐系数 可文件读取 可球谐分析获得
%         S2E_YMD             %数据跨度
%         R                   %地球平均曲率半径
%         %==================
%         %% %result
%         time                %时间标尺
%         
% %         Post_ewh            %gldas/trmm等非GRACE数据 后处理放置区
% %         Post_ewh_k          %GRACE结果尺度因子法放置区
% %         Post_ewh_fm         %GRACE结果fm法放置区
% %         
% %         Post_tws;
% %         Post_tws_k          %tws 尺度因子法放置区
% %         Post_tws_fm         %tws fm法放置区
% %         
% %         Pre_ewh             %原始数据放置区
% %         Pre_sigma           %原始数据误差放置区
% %         Pre_tws             %原始数据_tws
%         
% %         k                   %尺度矩阵
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
%                 error("Solution:    请输入数字（计算的分辨率）");
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
%                     error("Solution:    全球Resolution选项只有0.1 、0.25 、0.125、 0.5和1");
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
%             disp("解决方案创建成功");
%             disp('分辨率为');
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
%         %       读取数据方法                  %
%         %         Ins_Ver       SH_Dir
%         %         Lmax          R
%         %         SLR_address   SLR_flag
%         %         GEOC_address  GEOC_flag
%         %         SH            S2E_YMD
% Read_SH_DDK_GRACE(self);
% 
%         Read_SH_LEO(self);    %读取LEO信息
%         Read_SH_GRACE(self);    %读取GRACE信息
%         Read_SH_SWARM(self);    %读取SWARM信息
%         Read_SH_L1(self);       %读取GEOC一阶
%         Read_SH_C20(self);      %读取SLR C20
%         Read_SH_C30(self);       %读取SLR C20
%         %========================================
%         %%
%         %               处理方法设定                  %
%         %                Filter_Type
%         %   Filter_radius_l   Filter_radius_m
%         %                PnMl
%         %   Decor_flag        DD_polyfit_Degree
% %         pre_filter(self,Filter_Type,Filter_radius_l,Filter_radius_m);%滤波参数设定
%         pre_destrip(self,Decor_flag,DD_polyfit_Degree,DD_start_order);%去相关参数设定
%         pre_destriping(self,option);
%         %=======================================
%         %%
%         %               过程系数计算                   %
%         get_Coe(self,varargin);%计算过程系数
%         set_filter(self,varargin); %计算过程系数20230608添加的新版本
%         %         SH2EWH(self,varout_par);%计算ewh过误差
%         %=======================================
%         %%
%         %           绘图方法，设定与展示研究区域       %
%         get_mask(self,boundary_fir1,boundary_ceta1,boundary_fir2,boundary_ceta2);%设定研究区域
%         plot_region(self,type)%展示研究区域
%         %=======================================
%     end
% end
% 
% 
