%=========================================================
% 
%=========================================================

function [default] = NoiseAddFB_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'RelNoisePower';
default{m,1}.entrystr = '10';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Averages';
default{m,1}.entrystr = '1';