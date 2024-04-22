function [SH, dSH] = SH_read_auto(ip_dir_or_struct_name, fList)
% {{SH; read; general; GRACE}}
%{
automatically read in GRCOF2 and GFC formats of SH files

how to use:
% 1. filenames saved in a list
SH_read_auto('a/','fList')

% 2. a single file
SH_read_auto('filename1')

% 3. a file list created by `dir`
sname = dir('a/G*'); 
SH_read_auto(sname); 


INPUT:
ip_dir: iput dir
        or struct generated by dir('/path'), fList is not needed in this
        case
fList: file list

OUTPUT:
SH: a structure variable with fields of '.C' and '.S'

CALL:
strstr
read_time
read_gfc_one
read_grcof2_one

%}
ifile = 0;
if ~isstruct(ip_dir_or_struct_name) && nargin == 2 % input is ipdir & fList
    ip_dir = strstr(ip_dir_or_struct_name,'protect');
    fid = fopen( [ip_dir,fList],'r' );
    while ~feof(fid)        
        filename = strstr(fgetl(fid),'filename');
        ifile = ifile + 1;
        if ifile == 1
            fprintf( '%s%3d%s%s\n', 'ifile = ',ifile,' / reading : ', filename );
        elseif mod(ifile,5) == 0
            fprintf('%d, ',ifile);
        end
        
        [SH(ifile), dSH(ifile)] = SH_read_one([ip_dir,filename]);
        
    end
    fprintf('\n')

    fclose( fid );
elseif ~isstruct(ip_dir_or_struct_name) && nargin == 1 % input is a single filename
    sfile = ip_dir_or_struct_name;
    [SH, dSH] = SH_read_one(sfile);
else % input is sname = dir('/path');
    sname = ip_dir_or_struct_name;
    for ifile = 1:numel(sname)
        filename = sname(ifile).name;
        ip_dir = strstr(sname(ifile).folder,'protect');
        if ifile == 1
            fprintf( '%s%3d%s%s\n', 'ifile = ',ifile,' / reading : ', filename );
        elseif mod(ifile,5) == 0
            fprintf('%d, ',ifile);
        end

        [SH(ifile), dSH(ifile)] = SH_read_one([ip_dir,filename]);
        
    end
    fprintf('\n')
end
end

%%
function [SH0,dSH0] = SH_read_one(sfile)

[~, filename] = fileparts(sfile);

if strcmp(filename(end-3:end),'.gfc')
    [SH0,dSH0]=read_gfc_one(sfile);
else
    [SH0,dSH0]=read_grcof2_one(sfile);
end
end

function [SH, dSH] = read_grcof2_one(filename, varargin)
% in SH : C, S, dC, dS
% {{SH}} {{read}} {{grcof2}}
    
fid2 = fopen( filename, 'r');

PAR0 = struct('Nmax',0,'time_pattern','csr');
PAR = var_initial(PAR0, varargin);

%
% --- get iNmax, and jump over headings {
iNmax = 0;
iheader = 0;
while ~feof(fid2)
    str = fgetl(fid2);
    iheader = iheader + 1;
    if iNmax == 0 % find the iNmax
        if length(str)>3 && strcmp(str(1:3),'SHM') % RL05 version
            a = sscanf(str,'%s %d');   % for one parameter
            iNmax = a(4); % char(a(1:3)) = SHM
        elseif length(str) > 10 && strcmp(str(5:10),'degree') % RL06 version
            str = strtrim(str);
            iNmax = sscanf(str(end-1:end),'%d');
        end
    end
    %  for JPL files, there are 7 lines starting with 'SHM'
    if length(str)>6 && strcmp(str(1:6),'GRCOF2')
        break;
    end
end
Nheader = iheader - 1;
if iNmax == 0
    if PAR.Nmax == 0
        error('iNmax == 0');
    else
        iNmax = PAR.Nmax;
    end
end
fclose( fid2 );
% --- get iNmax, and jump over headings }


fid2 = fopen( filename, 'r');
% --- jump over headers
for ii = 1:Nheader
    fgetl(fid2);
end
% --- jump over headers

rC = zeros(iNmax+1);
rS = rC;
drC = rC;
drS = rS;
Nchar = 6;

ifirst_line_check = 1;
while ~feof(fid2)
    
    str = fgetl(fid2);
    % Caution 1 : each character will take a position in a, 'GRCOF2' will take
    %             6 positions, so Nchar = 6;
    % Caution 2 : Matlab can recognize format like 4.12e-2, but 4.12D-2 not
    a=sscanf(str,'%s %d %d %g %g %g %g');
    
    in = a(Nchar+1);
    im = a(Nchar+2);
    rC(in+1,im+1) = a(Nchar+3);
    rS(in+1,im+1) = a(Nchar+4);
    drC(in+1,im+1) = a(Nchar+5);
    drS(in+1,im+1) = a(Nchar+6);
        
    if ifirst_line_check == 1
        if (in~=0 && in~=1 && in~=2) || im~=0
            error('ERROR: In first line (%d,%d) should be (0,0) or (2,0)',in,im);            
        end
        ifirst_line_check = 0;
        if in==2 && im==0
            rC(1,1) = 1;
        end
    end
end
fclose(fid2);

[tt] = read_time(strstr(filename,'filename'), PAR.time_pattern);

if contains(filename,'_GRAC_')
    stype = 'GRACE_1';
    sunit = 'none';
elseif contains(filename,'_GRFO_')
    stype = 'GRACE_FO';
    sunit = 'none';
else
    stype = [];
    sunit = [];
end

s1 = strstr(filename,'justname');
s2 = regexp(s1,'(GSM|GA[A-D])','match');
if numel(s2) == 1
    
    s3 = regexp(s1,'(CSR|GFZ|JPL)','match');
    if numel(s3) == 1
        sname = [s3{1},'-',s2{1}];
    else
        sname = s2{1};
    end
else
    sname = 'unknown';
end

SH = cSH(rC, rS, tt);
SH = SH.setinfo('type',stype,'unit',sunit,'name',sname);
dSH = cSH(drC, drS, tt);
dSH = dSH.setinfo('type',stype,'unit',sunit,'name',['error-',sname]);
end

function result=strstr(strlist,method,ss)
% {{str}} {{tool}} {{condition}} {{win}}

% ss is for method 'cat'
% strstr(clist,'cat','|'), clist{1}|clist{2}|...|clist{end}
if nargin == 0
    disp('method supported:');
    disp('  justname: ''/a/b/c.txt'', return ''c''');
    return;
end

if strcmp(method,'cat') % process together
    if nargin == 2
        ss = ' ';
    end
    result = strlist{1};
    for ii = 2:numel(strlist)
        result = [result,ss,strlist{ii}];
    end
else % process one by one
    if ~iscell(strlist)
        str0 = strlist;
        result = process_str(str0,method);
    else
        Nstr = max(size(strlist));
        for ii = 1:Nstr
            str0 = strlist{ii};
            result{ii} = process_str(str0,method);
        end
    end 
end
end

function result=process_str(str0,method)
if strcmp(method,'justname')
    % '/a/b/c.txt', return 'c'
    %     [fpath, fname, ext] = fileparts(str0);
    [~, result] = fileparts(str0);
    
elseif strcmp(method,'ext')
    [~, ~, result] = fileparts(str0);
elseif strcmp(method,'path')
    % '/a/b/c.txt', return '/a/b/'
    [sdir,fname,sext] = fileparts(str0);
    if isempty(sext) % if no extension, then it is regarded as a path
        if ~isempty(fname)
            sdir =[sdir,filesep,fname];
        end
    end
    result=[sdir,filesep];
    
elseif strcmp(method,'filename')
    % '/a/b/c.txt', return 'c.txt'
    
    [~, name,ext] = fileparts(str0);
    result = [name,ext];
    
elseif strcmp(method,'each')
    % '/a/b/c.txt', return {'a','b'}
    a = regexp(str0, filesep); % filesep: '/' for MAC, '\' for win
    
    for ii = 1:numel(a)-1
        result{ii} = str0(a(ii)+1:a(ii+1)-1);
    end
    if a(end) ~= numel(str0) % str0 end not with '/'
        result{ii+1} = str0(a(ii+1)+1:end);
    end
        
elseif strcmp(method,'protect')
    % '/a/b' or '/a/b/', return '/a/b/'
    
    str0 = strrep(str0,'\','/');
    if ~strcmp(str0(end),'/')
        result=[str0,'/'];
    else
        result = str0;
    end
elseif strcmp(method,'title')
    % 'a_b_c' --> 'a\_b\_c'
    result = strrep(str0,'_','\_');
elseif strcmp(method,'capital_first')
    % 'abc' -> 'Abc'
    result = [upper(str0(1)),str0(2:end)];
elseif strcmp(method,'structname')
    % make sure that a string can be used for the name of a struct field
    str0 = regexprep(str0,'^[\W\d]+|\W*','_');
    str0 = regexprep(str0,'^_+|_+$',''); % remove the beginning _ and ending _
    result = str0;
    if numel(result)>63 % the maximum length for a field name is 63
        result = result(1:63);
    end
else
    disp(['not supported method : ',method]);
    error('error');
end
end
    