%=========================================================
% 
%=========================================================

function [default] = B0MapOffResSphereRim_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mat)';
default{m,1}.entrystr = '240';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'RimThick (mat)';
default{m,1}.entrystr = '2';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'OffRes (Hz)';
default{m,1}.entrystr = '400';