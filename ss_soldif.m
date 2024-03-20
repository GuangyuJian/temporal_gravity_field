function [ss]=ss_soldif(objt,objf)
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
% date: 2024-03-15
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
x=objt.value;
y=objf.value;

[r,c,n]=size(x);

for row=1:r
    for col=1:c
        tempx=squeeze(x(row,col,:));
        tempy=squeeze(y(row,col,:));
        mx=mean(tempx);
        my=mean(tempy);

        temp=sum((tempx-tempy).^2);
        ss.rmse(row,col)=sqrt(temp/n);

        temp2=sum((tempx-mx).^2);
        ss.nse(row,col)=1-temp/temp2;

        temp3=abs(tempx-mx)+abs(tempy-my);
        ss.ioa(row,col)=1-temp/sum(temp3.^2);

    end
end


end

