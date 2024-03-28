%=========================================================
% 
%=========================================================

function [default] = Cyllinder_v1c_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Diam (mm)';
default{m,1}.entrystr = '210';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Length (mm)';
default{m,1}.entrystr = '210';

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'Orient';
default{m,1}.entrystr = 'Z';
default{m,1}.options = {'X','Y','Z'};