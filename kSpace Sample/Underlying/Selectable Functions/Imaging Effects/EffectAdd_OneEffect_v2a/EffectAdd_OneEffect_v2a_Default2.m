%=========================================================
% 
%=========================================================

function [default] = EffectAdd_OneEffect_v2a_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    effect1path = [SCRPTPATHS.pioneerloc,'Analysis\Underlying\zz Underlying\Selectable Functions\Simulated Imaging\Imaging Effects\Signal Decay Functions\'];
elseif strcmp(filesep,'/')
end
effect1func = 'SigDec_MonoExp_v2a';

m = 1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'Effect1func';
default{m,1}.entrystr = effect1func;
default{m,1}.searchpath = effect1path;
default{m,1}.path = [effect1path,effect1func];
