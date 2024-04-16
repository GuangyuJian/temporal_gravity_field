function [h]=tsa_fft(self,fs,trange,fillflag)
% [h]=tsa_fft(self,fs,trange)
% usage: self.tsa_fft(fs,trange)
% this method show the fft results of time series
%----------------------------------------------------------------------------
% In   :self    [1x1] sol_ts
%       fs:     [1x1] sample frequency (12 means monthly series)
%       trange  [1x4] the series we want to estimate by FFT
%               e.g [2002,4,2022,12] means 200204-202212
%       fillflag [1x1] 1 -> need gap filling 
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
if nargin==3
    fillflag=0;
end

if fillflag==1
    self2=self.filling(trange);
else
%     self2=sol_ts(self.value,self.unit);
    self2=self.extra('trange',trange);
%     self.set_time(self.time,self.int_year,self.int_month);
end
ts=self2.value(:);

T = 1/fs;             % Sampling period
L=length(ts);%时间序列长度 Length of signal
t = (0:L-1)*T;        % Time vector
X=ts;

Y = fft(X);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
% f=round(f,2);
p=1./f;
% % f=round(1./f,2);

h=semilogx(p,P1,'LineWidth',2,'color',[0 0 0],'LineStyle','-');
xlabel_str=[0 0.05 0.1 0.2 0.3 0.5 1 1.19 1.46  2.12  3.18 3.8  4.77 6.36 12  19];

xticks(xlabel_str);
xlabel('周期（年）');
ylabel('幅值（ ）');
grid on;
box on;
end

