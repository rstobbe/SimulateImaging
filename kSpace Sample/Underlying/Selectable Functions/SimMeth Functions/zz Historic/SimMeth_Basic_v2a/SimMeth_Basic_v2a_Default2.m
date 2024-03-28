%=========================================================
% 
%=========================================================

function [default] = SimMeth_Basic_v2a_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    objectpath = [SCRPTPATHS.pioneerloc,'kSpaceSample\Underlying\Selectable Functions\Object Functions\Numerical\'];    
    samplepath = [SCRPTPATHS.voyagerloc,'kSpaceSample\Underlying\Selectable Functions\kSpace Sample\'];  
    effectpath = [SCRPTPATHS.pioneerloc,'kSpaceSample\Underlying\Selectable Functions\Imaging Effects\']; 
elseif strcmp(filesep,'/')
end
objectfunc = 'SimObject_Sphere_v2a';
samplefunc = 'kSampGrdSimCudaSingles_v2a';
effectfunc = 'EffectAdd_NoEffect_v2a';

m = 1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'Objectfunc';
default{m,1}.entrystr = objectfunc;
default{m,1}.searchpath = objectpath;
default{m,1}.path = [objectpath,objectfunc];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'Samplefunc';
default{m,1}.entrystr = samplefunc;
default{m,1}.searchpath = samplepath;
default{m,1}.path = [samplepath,samplefunc];

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'EffectAddfunc';
default{m,1}.entrystr = effectfunc;
default{m,1}.searchpath = effectpath;
default{m,1}.path = [effectpath,effectfunc];

