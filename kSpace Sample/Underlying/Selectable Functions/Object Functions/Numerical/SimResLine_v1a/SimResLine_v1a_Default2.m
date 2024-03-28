%=========================================================
% 
%=========================================================

function [default] = SimResLine_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mm)';
default{m,1}.entrystr = '170';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'LineWidth (mm)';
default{m,1}.entrystr = '1';