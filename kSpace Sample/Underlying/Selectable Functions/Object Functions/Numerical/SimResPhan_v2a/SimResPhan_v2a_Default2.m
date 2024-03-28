%=========================================================
% 
%=========================================================

function [default] = SimResPhan_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ObMatSz';
default{m,1}.entrystr = '160';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ObDim (mm)';
default{m,1}.entrystr = '240';

