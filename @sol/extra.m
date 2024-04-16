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
        trange=varargin{2};

        switch varargin{1}

            case 'trange'
                if length(trange)~=4
                    disp("e.g., sol2=sol1.extra('trange',[2002,4,2004,5]) ");
                    error('! wrong argument :trange');
                end
                y1=trange(1); y2=trange(3);
                m1=trange(2); m2=trange(4);

                ly1=(self.int_year==y1);
                ly2=(self.int_year==y2);
                lm1=(self.int_month==m1);
                lm2=(self.int_month==m2);

                lym1=ly1.*lm1; lym2=ly2.*lm2;
                llc=find(lym1==1):1:find(lym2==1);

                clear ly1 ly2 lm1 lm2 lym1 lym2;

            case 'trange2'
                if length(trange)~=4
                    disp("e.g., sol2=sol1.extra('trange',[2002,4,2004,5]) ");
                    error('! wrong argument :trange');
                end

                trange=varargin{2};
                y1=trange(1); y2=trange(3);
                m1=trange(2); m2=trange(4);
                ymd1=y1+(m1-0.5)/12;
                ymd2=y2+(m2-0.5)/12;
                llc=find(self.time<=ymd2&self.time>=ymd1);
            otherwise
                error('! wrong argument ');

        end

    case 3

        if strcmp(varargin{1},'one')||strcmp(varargin{1},'ym')
            switch length(varargin)
                case 3
                    y1=varargin{2};
                    m1=varargin{3};
                    if length(y1)~=1||length(m1)~=1
                        error('! wrong argument :one or ym');
                    end
                case 2

                    ym=varargin{2};
                    if length(ym)~=1
                        error('! wrong argument :one or ym');
                    else
                        y1=ym1(1);
                        m1=ym1(2);
                    end
                otherwise
                    error('length varagin <2');
            end
            ly1=(self.int_year==y1);
            lm1=(self.int_month==m1);
            llc=find(ly1.*lm1==1);
            clear ly1  lm1  lym1;
        else
            error('! wrong argument:one or ym');
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
self2.append_info(['extra from ' num2str(llc(:)') '\r']);
end

