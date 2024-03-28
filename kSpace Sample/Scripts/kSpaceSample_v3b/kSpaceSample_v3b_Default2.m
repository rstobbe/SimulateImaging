%=========================================================
% 
%=========================================================

function [default] = kSpaceSample_v3b_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    objectpath = [SCRPTPATHS.pioneerloc,'kSpaceSample\Underlying\Selectable Functions\Object Functions\Numerical\'];    
    samplepath = [SCRPTPATHS.voyagerloc,'kSpaceSample\Underlying\Selectable Functions\kSpace Sample\'];  
    effectpath = [SCRPTPATHS.pioneerloc,'kSpaceSample\Underlying\Selectable Functions\Imaging Effects\']; 
elseif strcmp(filesep,'/')
end
objectfunc = 'Sphere_v1d';
samplefunc = 'kSampGrdSimCudaSingles_v1e';
effectfunc = 'NoEffect_v1a';

m = 1;
default{m,1}.entrytype = 'OutputName';
default{m,1}.labelstr = 'Sampling_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'ScriptName';
default{m,1}.labelstr = 'Script_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'RunExtFunc';
default{m,1}.labelstr = 'Imp_File';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Load';
default{m,1}.runfunc1 = 'LoadTrajImpCur';
default{m,1}.(default{m,1}.runfunc1).curloc = SCRPTPATHS.outloc;
default{m,1}.runfunc2 = 'LoadTrajImpDef';
default{m,1}.(default{m,1}.runfunc2).defloc = SCRPTPATHS.outloc;

m = m+1;
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

m = m+1;
default{m,1}.entrytype = 'RunScrptFunc';
default{m,1}.scrpttype = 'kSpaceSample';
default{m,1}.labelstr = 'Sample_kSpace';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Sample';

