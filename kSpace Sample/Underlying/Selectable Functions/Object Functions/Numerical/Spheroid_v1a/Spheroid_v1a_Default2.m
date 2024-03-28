%=========================================================
% 
%=========================================================

function [default] = Spheroid_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'BaseDiam (mm)';
default{m,1}.entrystr = '200';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Elip';
default{m,1}.entrystr = '1.2';

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'Orient';
default{m,1}.entrystr = 'Z';
default{m,1}.options = {'X','Y','Z'};