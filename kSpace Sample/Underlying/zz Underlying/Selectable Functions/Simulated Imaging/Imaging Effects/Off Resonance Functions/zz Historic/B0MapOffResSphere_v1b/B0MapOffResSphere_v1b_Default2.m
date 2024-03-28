%=========================================================
% 
%=========================================================

function [default] = B0MapOffResSphere_v1b_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mat)';
default{m,1}.entrystr = '20';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'OffRes (Hz)';
default{m,1}.entrystr = '50';