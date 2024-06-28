%=========================================================
% 
%=========================================================

function [default] = BiExpAddTE_v1b_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'T2f (ms)';
default{m,1}.entrystr = '1.0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'FracT2f';
default{m,1}.entrystr = '0.6';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'T2s (ms)';
default{m,1}.entrystr = '20';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'StartVal';
default{m,1}.entrystr = '1.0';


