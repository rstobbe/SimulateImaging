%=========================================================
% 
%=========================================================

function [default] = Plane_v1c_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Thick (mm)';
default{m,1}.entrystr = '2';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Length (mm)';
default{m,1}.entrystr = '10';
