%=========================================================
% 
%=========================================================

function [default] = MultiPlane_v1c_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Thick (mm)';
default{m,1}.entrystr = '1.8';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Length (mm)';
default{m,1}.entrystr = '120';
