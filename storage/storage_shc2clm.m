function [clm]=storage_shc2clm(shc,maxn)                               

%----------------------------------------------------------------------------
% In   :    shc     [struct{C;S}]
%                   a structure storages values of c and s
%                   (stored as degree-leading format) in its subfield
%                   shc.c and shc.s, respectively.
%           nontion:
%                   Lmax means maximum degree; tt means the length of shc
%           e.g.,shc(i).C
%                   =[  c00(i)  ]
%                    [  c10(i)  ]
%                    [  ...     ]
%                    [  cLmaxLmax(i)]
%           nmax     [1x1] maximum degree
% Out  :
%    vecc            [kx1]   coefficients in vector shape: cosine part
%    vecs            [kx1]   coefficients in vector shape: sine part
%    nm              [2xk]   ordering vector the first column is degree,
%                               the second column is order
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
ntime=length(shc);
if ntime>1
error('more than one shc');
end

[nn,mm]=get_nnmm(maxn);
clm=[nn mm shc.cnm shc.snm];
                  
                              
                              
end

