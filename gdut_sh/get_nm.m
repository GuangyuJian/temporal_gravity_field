function [loc]=get_nm(n,m)
%
%----------------------------------------------------------------------------
% In   :
%       (n,m) (degree, order)
%        ([1x1],[1xlength(m)]);
%        ([1xlength(m)],[1x1]);
%        ([1x1],[1x1]);
%
% Out  : loc location of input (degree, order)
%       [length(m)x1]
%       [length(n)x1]
%       [1x1]
%----------------------------------------------------------------------------


% Authors: Karl Jian (K.J)
% address: Guangdong University of Technology(GDUT)
% email: gyjian@mail2.gdut.edu.cn
% date: 2024-01-19
% MATLAB_version: 9.12.0.1884302 (R2022a)
%**************************************************************************
%Ref:
%**************************************************************************

if isscalar(n)
    if isscalar(m)
        loc=2+(n+2)*(n-1)/2+m;
    else
        loc=2+(n+2)*(n-1)/2.+m;
    end
else
    if isscalar(m)
        loc=2+(n+2).*(n-1)/2+m;
    else
        error('n and m cen not be vector format at the same time');
    end
end
loc=loc(:);

end

