function [h]=mov_ts_plot(self,windows)
%
%----------------------------------------------------------------------------
% In   :
%
% Out  :
%
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Sun Yat-sen University   (SYSU)
% email: temp~~
% supervisor: Min zhong
%----------------------------------------------------------------------------
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% supervisor: Chuang Xu
% date: 2024-04-04
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************

for k=1:length(self)
    tempts=self(k);

    temp2 = math_MovingAverage(tempts.value,windows);
    n=windows-1;
    n=n/2;
    h(k)=plot(tempts.time(n+1:end-n),temp2(n+1:end-n),'LineWidth',1.5);
    ylabel(tempts.unit);
    xlabel('Year');
    title(tempts.name);
    %     set(gca,'FontSize',12,'FontWeight','Bold');
    set(gca,'FontSize',10,'FontUnits','points')
    grid on;
    box on;
    hold on;
end


end
function res = math_MovingAverage(input,N)
%% input为平滑前序列(列向量和行向量均可)；N为平滑点数（奇数）；
% res返回平滑后的序列(默认行向量)。
sz = max(size(input));
n = (N-1)/2;
res = [];
for i = 1:length(input)
    
    
    if i <= n
        res(i) = sum(input(1:2*i-1))/(2*i-1);
        
    elseif i < length(input)-n+1
        res(i) = sum(input(i-n:i+n))/(2*n+1);
        
    else
        temp = length(input)-i+1;
        res(i) = sum(input(end-(2*temp-1)+1:end))/(2*temp-1);
        
    end

    
end



end

