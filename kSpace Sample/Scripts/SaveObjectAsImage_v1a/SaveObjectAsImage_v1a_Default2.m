%=========================================================
% 
%=========================================================

function [default] = SaveObjectAsImage_v1a_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    objectpath = [SCRPTPATHS.pioneerloc,'kSpaceSample\Underlying\Selectable Functions\Object Functions\Numerical\'];    
elseif strcmp(filesep,'/')
end
objectfunc = 'Sphere_v1d';

m = 1;
default{m,1}.entrytype = 'OutputName';
default{m,1}.labelstr = 'Sampling_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'ScriptName';
default{m,1}.labelstr = 'Script_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'FoV (mm)';
default{m,1}.entrystr = '220';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SubSamp';
default{m,1}.entrystr = '1.6';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ZeroFill';
default{m,1}.entrystr = '256';

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'Objectfunc';
default{m,1}.entrystr = objectfunc;
default{m,1}.searchpath = objectpath;
default{m,1}.path = [objectpath,objectfunc];

m = m+1;
default{m,1}.entrytype = 'RunScrptFunc';
default{m,1}.scrpttype = 'save';
default{m,1}.labelstr = 'Save Object';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Run';

