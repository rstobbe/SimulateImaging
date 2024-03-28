%=========================================================
% 
%=========================================================

function [default] = AddPhase_Linear_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Start (rads)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Periods';
default{m,1}.entrystr = '1';

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'Dimension';
default{m,1}.entrystr = 'x';
default{m,1}.options = {'x','y','z'};