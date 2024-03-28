%=========================================================
% 
%=========================================================

function [default] = SimResPhan_v3b_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mm)';
default{m,1}.entrystr = '240';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ResDiam (mm)';
default{m,1}.entrystr = '5';