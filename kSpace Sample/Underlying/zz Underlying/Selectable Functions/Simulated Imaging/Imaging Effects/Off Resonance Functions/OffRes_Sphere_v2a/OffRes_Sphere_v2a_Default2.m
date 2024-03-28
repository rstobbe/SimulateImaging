%=========================================================
% 
%=========================================================

function [default] = OffRes_Sphere_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mm)';
default{m,1}.entrystr = '240';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Delay (ms)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'OffRes (Hz)';
default{m,1}.entrystr = '400';