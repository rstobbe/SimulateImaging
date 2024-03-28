%=========================================================
% 
%=========================================================

function [default] = B0Analysis_v1b_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    b0path = [SCRPTPATHS.pioneerloc,'Analysis\Underlying\zz Underlying\Selectable Functions\Simulated Imaging\Imaging Effects\Off Resonance Functions\'];
elseif strcmp(filesep,'/')
end
b0func = 'B0MapLoad_v1a';
addpath([b0path,b0func]);

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'TE (ms)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'OffResfunc';
default{m,1}.entrystr = b0func;
default{m,1}.searchpath = b0path;
default{m,1}.path = [b0path,b0func];
