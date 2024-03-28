%=========================================================
% 
%=========================================================

function [default] = SplitCyllinder_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ObMatSz';
default{m,1}.entrystr = '240';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Diam (mm)';
default{m,1}.entrystr = '210';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Length (mm)';
default{m,1}.entrystr = '210';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Split (mm)';
default{m,1}.entrystr = '20';
