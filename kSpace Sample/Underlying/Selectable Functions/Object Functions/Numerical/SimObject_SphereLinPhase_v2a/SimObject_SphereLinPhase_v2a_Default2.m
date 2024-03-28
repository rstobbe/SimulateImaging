%=========================================================
% 
%=========================================================

function [default] = SimObject_SphereLinPhase_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mm)';
default{m,1}.entrystr = '200';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Start (cycle)';
default{m,1}.entrystr = '-1';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Periods';
default{m,1}.entrystr = '1';

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'Dimension';
default{m,1}.entrystr = 'x';
default{m,1}.options = {'x','y','z'};
