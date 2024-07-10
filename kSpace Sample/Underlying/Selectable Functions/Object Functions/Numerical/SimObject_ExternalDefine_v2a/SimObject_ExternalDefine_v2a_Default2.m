%=========================================================
% 
%=========================================================

function [default] = SimObject_Spheroid_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'BaseSphereDiam (mm)';
default{m,1}.entrystr = '200';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'xStretch';
default{m,1}.entrystr = '1.0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'yStretch';
default{m,1}.entrystr = '1.0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'zStretch';
default{m,1}.entrystr = '1.0';
