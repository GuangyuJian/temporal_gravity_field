function self=set_filter(self,varargin)
if nargin==1
    disp(self);
    disp('set_filter:请注意，为创建预处理方案，将采用默认值 即无处理');
end

% Filter_Type,rn,rm
if nargin>=2
    switch varargin{1}
        case 'none'
            if nargin>2
                disp(self);
                error('set_filter：None 无需其他参数');
            end
            if nargin==2
                self.Filter_Type='none';
            end
%----------------------------------------------------------------
        case 'gauss'
            if nargin==2
                disp(self);
                error('set_filter：Gauss需要输入l阶参数');
            end
            if nargin==3
                self.Filter_Type=varargin{1};
                self.rn=varargin{2};
            end
            if nargin>3
                disp(self);
                error('set_filter：Gauss 无需m阶参数');
            end
%----------------------------------------------------------------
        case 'fan'
            if nargin==2
                disp(self);
                error('set_filter：Fan需要输入l阶m次参数');
            end

            if nargin==3
                self.Filter_Type='fan';
                self.rn=varargin{2}(1);
                self.rm=varargin{2}(1);
            end

            if nargin>3
                self.Filter_Type='fan';
                error('set_filter：Fan 无需m阶参数');
            end
%----------------------------------------------------------------
        case 'han'

            if nargin>0
                disp(self);
                error('set_filter：han建议使用默认');
            end


%----------------------------------------------------------------
        case 'rec'
            if nargin~=5
                %                 disp(self);
                disp("--------------------------------------------");
                disp("set_filter('rec',recn,'basic_type',r)");
                disp("e.g. set_filter('rec',recn,'gauss',r)");
                disp("e.g. set_filter('rec',recn,'fan',r)");
                disp("--------------------------------------------");
                error('参数形式如上');

            elseif nargin==5
                self.Filter_Type=['rec' varargin{3}];
                self.recn=varargin{2};

                switch varargin{3}
                    case 'gauss'
                        self.rn=varargin{4};
                    case 'fan'
                        self.rn=varargin{4};
                        self.rm=varargin{4};
                    otherwise
                        error('wrong');
                end
            end

%----------------------------------------------------------------
        otherwise
            disp("-----------------------------");
            disp("set_filter('none')");
            disp("set_filter('gauss',r)");
            disp("set_filter('fan',r)");
            disp("set_filter('han')");
            disp("-----------------------------");
            disp("set_filter('rec',recn,'basic_type',r)");
            disp("e.g. set_filter('rec',recn,'gauss',r)");
            disp("e.g. set_filter('rec',recn,'fan',r)");
            disp("-----------------------------");
            error('滤波类型输入应该为 none\gauss\fan\rec');
    end

end
self.get_wnm();

end

