%=========================================================
% 
%=========================================================

function [default] = SigDecayAdd_v1a_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    sigdecpath = [SCRPTPATHS.pioneerloc,'Analysis\Underlying\zz Underlying\Selectable Functions\Simulated Imaging\Imaging Effects\Signal Decay Functions\'];
elseif strcmp(filesep,'/')
end
sigdecfunc = 'BiExpAddTE_v1a';

m = 1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'SigDecfunc';
default{m,1}.entrystr = sigdecfunc;
default{m,1}.searchpath = sigdecpath;
default{m,1}.path = [sigdecpath,sigdecfunc];
