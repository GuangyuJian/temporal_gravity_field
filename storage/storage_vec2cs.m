function [cs]=storage_vec2cs(nm,vecc,vecs)
%
%----------------------------------------------------------------------------
% storage_vec2cs rearranges a vector shaped set of spherical harmonic
% coefficients into cs-format. The vector order is given by the ordering
% vector.

%
% IN:
%    nm ...... ordering vector                                      [2,k]
%              maximum degree - degree-wise ordering is assumed     [1,1]
%    vecc ..... coefficients in vector shape: cosine part            [1,k]
%    cecs ..... coefficients in vector shape: sine part              [1,k]
%
% OUTPUT:
%    cs ..... output in cs- or sc- format
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2023-12-10
% MATLAB_version: 9.12.0.1884302 (R2022a)
% Encode: UTF-8
%**************************************************************************
%Ref:
% To  save energy and keep line with our own project， we directly use some
% function from project 'SHBundle'
%**************************************************************************
% out = vec2cs(nm,inC,inS);  %this function comed from project 'SHBundle'.

for k=1:length(vecc)

    nn=nm(k,1);
    mm=nm(k,2);
    cs(nn+1,mm+1)=vecc(k);
    if mm~=0
        cs(mm,nn+1)=vecs(k);
    end

end
end

