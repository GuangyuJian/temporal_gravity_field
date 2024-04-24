function [self]=pre_destrip_mcf(self,varargin)
% [self]=pre_destrip_mcf(self,varargin)
%--------------------------------------------------------------------------
% In   : self   [1x1] @sol_filter
%           optional:
% ----------------------using default parameter----------------------------
%                       self.pre_destrip_mcf('SSAS');
%                       self.pre_destrip_mcf('ssas');
%                       self.pre_destrip_mcf('MVMDS');
%                       self.pre_destrip_mcf('mvmds');
%                       self.pre_destrip_mcf('VMDS');
%                       self.pre_destrip_mcf('vmds'); 
% ----------------------using user-definded parameter----------------------
%                       self.pre_destrip_mcf('VMDS',kmax,alpha,fk);
%                       self.pre_destrip_mcf('vmds',kmax,alpha,fk);
%-------------------------------------------------------------------------- 
%       notes:
%       kmax    [1x1] double    the total number of mode(unitless) 
%       alpha   [1x1] double    the alpha factor (unitless)
%       fk      [1x1] double    the cut-off frequency (Hz)
%       
% Out  :
%       self [1x1] @sol_filter
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-23
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

switch varargin{1}

    case {'SSAS','ssas'}
        self.mcf_destrip_type=varargin{1};
        
    case {'VMDS','vmds'}
        self.mcf_destrip_type=varargin{1};
        if length(varargin)==1
            kmax=15;
            alpha=10;
            fk=55/360;

        elseif length(varargin)==4
            kmax=varargin{2};
            alpha=varargin{3};
            fk=varargin{4};
        else
            error("pre_destrip_mcf('vmds',kmax,alpha,fk)");
        end
        self.mcf_par=struct('kmax',kmax,...
            'alpha',alpha,...
            'fk',fk);

    case {'MVMDS','mvmds'}
        self.mcf_destrip_type=varargin{1};
%         if length(varargin)==1
%             kmax=15;
%             alpha=10;
%             fk=55/360;
% 
%         elseif length(varargin)==4
%             kmax=varargin{2};
%             alpha=varargin{3};
%             fk=varargin{4};
%         else
%             error("pre_destrip_mcf('mvmds',kmax,alpha,fk)");
%         end
%         self.mcf_par=struct('kmax',kmax,...
%             'alpha',alpha,...
%             'fk',fk);
    otherwise
        error('! SSAS or VMDS or MVMDS');

end
self.destrip_flag=4;
end

