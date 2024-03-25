function self=pre_destrip_fw(self,option)
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
          
          case 'none'
              self.fw_destrip_type=option;
          case 'swenson'
              self.fw_destrip_type=option;
          case 'chambers2007'
              self.fw_destrip_type=option;
          case 'chambers2012'
              self.fw_destrip_type=option;
          case 'chenp3m6'
              self.fw_destrip_type=option;
          case 'chenp4m6'
            self.fw_destrip_type=option;
          case 'duan'    
              self.fw_destrip_type=option;
          otherwise
              error('Wrong in destrip type');
      end
%         disp(fw_destrip_type);
        self.destrip_flag=2;

end