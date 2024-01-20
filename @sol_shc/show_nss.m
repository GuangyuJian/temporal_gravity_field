function [h]=show_nss(self,tt,mm,type)
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
% date: 2024-01-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
if nargin==3
    type='c';
end
shc= self.storage;

maxn=self.maxn;
nn=mm:maxn;

if mod(mm,2)==0
    nn_odd=mm+1:2:maxn;
    nn_even=mm:2:maxn;
else
    nn_even=mm+1:2:maxn;
    nn_odd=mm:2:maxn;
end

locn=get_nm(nn,mm);
loc_odd=get_nm(nn_odd,mm);
loc_even=get_nm(nn_even,mm);

switch type

    case 'c'
        temp=shc(tt).cnm;
titlename=['C_{nm} (m=' num2str(mm) ,')'];
    case 's'
        temp=shc(tt).snm;
        titlename=['S_{nm} (m=' num2str(mm) ,')'];
end
nexttile;
h=plot(nn,temp(locn),'black-');
rg=[-1.2*max(abs(temp(locn))) 1.2*max(abs(temp(locn)))];
grid on;
box on;
xlabel('degree');
ylabel('coefficient');

hold on;
% nexttile;    
h2=plot(nn_odd,temp(loc_odd),'r-',nn_even,temp(loc_even),'b-');
rg=[-2*max(abs(temp(locn))) 2*max(abs(temp(locn)))];

ylim(rg);
xlim([0 maxn]);
grid on;
box on;
xlabel('degree');
ylabel('coefficient');
fontsize(gca,12,'points')

l=legend('odd+even','odd','even');
l.Location="northwest";
l.NumColumns=3;
title(titlename);
end

