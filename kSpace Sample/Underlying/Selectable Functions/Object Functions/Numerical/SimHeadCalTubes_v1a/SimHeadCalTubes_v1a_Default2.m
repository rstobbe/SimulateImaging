%=========================================================
% 
%=========================================================

function [default] = SimHeadCalTubes_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'HeadWid (mm)';
default{m,1}.entrystr = '180';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'IoFov (mm)';
default{m,1}.entrystr = '180';

