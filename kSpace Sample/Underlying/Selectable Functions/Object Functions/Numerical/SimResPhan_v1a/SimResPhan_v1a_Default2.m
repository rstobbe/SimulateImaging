%=========================================================
% 
%=========================================================

function [default] = SimResPhan_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ObMatSz';
default{m,1}.entrystr = '64';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ObFoV (mm)';
default{m,1}.entrystr = '250';

