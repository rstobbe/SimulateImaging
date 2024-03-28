%=========================================================
% 
%=========================================================

function [default] = RecProf8_v1d_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'DropOffFact';
default{m,1}.entrystr = '1.8';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Xinset';
default{m,1}.entrystr = '10';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Yinset';
default{m,1}.entrystr = '10';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Zinset';
default{m,1}.entrystr = '20';