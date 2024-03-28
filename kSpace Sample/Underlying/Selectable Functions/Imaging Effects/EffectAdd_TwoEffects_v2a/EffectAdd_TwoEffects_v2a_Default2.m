%=========================================================
% 
%=========================================================

function [default] = EffectAdd_TwoEffects_v2a_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    effect1path = [SCRPTPATHS.pioneerloc,'Analysis\Underlying\zz Underlying\Selectable Functions\Simulated Imaging\Imaging Effects\Signal Decay Functions\'];
    effect2path = [SCRPTPATHS.pioneerloc,'Analysis\Underlying\zz Underlying\Selectable Functions\Simulated Imaging\Imaging Effects\Signal Decay Functions\'];
elseif strcmp(filesep,'/')
end
effect1func = 'MultiRcvr_SphereDistCloser_v3a';
effect2func = 'OffRes_Sphere_v2c';

m = 1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'Effect1func';
default{m,1}.entrystr = effect1func;
default{m,1}.searchpath = effect1path;
default{m,1}.path = [effect1path,effect1func];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'Effect2func';
default{m,1}.entrystr = effect2func;
default{m,1}.searchpath = effect2path;
default{m,1}.path = [effect2path,effect2func];

