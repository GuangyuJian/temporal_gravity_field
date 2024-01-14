function [sht]=storage_shct2sht(shct)                               
%[sh]=storage_shc2sht(shc)                                
%----------------------------------------------------------------------------
% In   :    shc     [struct{C;S}] 
%                   a structure storages values of c and s 
%                   (stored as degree-leading format) in its subfield
%                   shc.c and shc.s, respectively.
%           nontion:
%                   Lmax means maximum degree
%                   tt means the length of shc
%           e.g.,    
%           shc(i).C=[  c00(i)  ]
%                    [  c10(i)  ]
%                    [  ...     ]
%                    [  cLmaxLmax(i)]
%                              
% Out  :    sht       [(Lmax+1)*(Lmax+2) x tt] 
%                   a matrix storages the temporal changes of all c and s
%               e.g.,  
%             [c00(1) ···  c00(i) ··· c00(tt)]
%             [c10(1) ···  c10(i) ··· c10(tt)]
%             [...    ...  ...    ... ...    ]
%             [cLmaxLmax(1) ···  cLmaxLmax(i) ··· cLmaxLmax(tt)]
%             [s00(1) ···  s00(i) ··· s00(tt)]
%             [...    ...  ...    ... ...    ]
%             [sLmaxLmax(1) ···  sLmaxLmax(i) ··· sLmaxLmax(tt)]  
% 
%----------------------------------------------------------------------------
                                                          
% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
%**************************************************************************
tt=length(shct);
nsh=length(shct(1).cnm);

sht=zeros(nsh*2,tt);
for i=1:tt         
sht(:,i)=[shct(i).cnm;shct(i).snm];
end

end

