function pre_destriping(self,option)
%这个函数接口冯伟老师的去相关函数包
% option是去相关的选项
% NONE, 
% SWENSON, 
% CHAMBERS2007,
% CHAMBERS2012, 
% CHENP3M6, CHENP4M6, 
% DUAN
%========================================
      switch option
          
          case 'NONE'
              self.fw_destrip_type=option;
          case 'SWENSON'
              self.fw_destrip_type=option;
          case 'CHAMBERS2007'
              self.fw_destrip_type=option;
          case 'CHAMBERS2012'
              self.fw_destrip_type=option;
          case 'CHENP3M6'
              self.fw_destrip_type=option;
          case 'CHENP4M6'
            self.fw_destrip_type=option;
          case 'DUAN'    
              self.fw_destrip_type=option;
          otherwise
              error('Wrong in destrip type');
      end
%         disp(fw_destrip_type);
        self.fw_destrip_flag=1;



end