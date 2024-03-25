function [self2]=extra(self,varargin)
%
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

switch length(varargin)
    case 1
        llc=varargin{1};

    case 2
        if strcmp(varargin{1},'trange')
            trange=varargin{2};
            if length(trange)~=4
                error('! wrong argument :trange');
            else
                y1=trange(1);
                y2=trange(3);
                m1=trange(2);
                m2=trange(4);

                ly1=(self.int_year==y1);
                ly2=(self.int_year==y2);
                lm1=(self.int_month==m1);
                lm2=(self.int_month==m2);

                lym1=ly1.*lm1;
                lym2=ly2.*lm2;

                llc=find(lym1==1):1:find(lym2==1);

                clear ly1 ly2 lm1 lm2 lym1 lym2;
            end
        else
            error('! wrong argument ');
        end

        case 3
        if strcmp(varargin{1},'one')
            y1=varargin{2};
            m1=varargin{3};
            if length(y1)~=1||length(m1)~=1
                error('! wrong argument :trange');
            else

                ly1=(self.int_year==y1);
                lm1=(self.int_month==m1);
  
                lym1=ly1.*lm1;
                llc=find(lym1==1);
                clear ly1  lm1  lym1 ;
            end
        else
            error('! wrong argument 3');
        end

    otherwise
        error('!');
end



switch class(self)

    case 'sol_sf'
        self2=sol_sf(self.value(:,:,llc),self.unit,self.fir,self.ceta);
    case 'sol_ts'
        self2=sol_ts(self.value(llc),self.unit);
    case 'sol_shc'
        self2=sol_shc(self.storage(llc),self.maxn,self.storage_type,self.type);
end

time=self.time(llc);
int_year=self.int_year(llc);
int_month=self.int_month(llc);
self2.set_time(time,int_year,int_month);
self2.append_info(self.info);
self2.append_info(['extra from ' num2str(llc) '\r']);
end

