%=========================================================
% 
%=========================================================

function [default] = SimMeovPhanFlexible_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mm)';
default{m,1}.entrystr = '240';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ResDiam1 (mm)';
default{m,1}.entrystr = '6';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ResDiam2 (mm)';
default{m,1}.entrystr = '5.5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ResDiam3 (mm)';
default{m,1}.entrystr = '5.0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ResDiam4 (mm)';
default{m,1}.entrystr = '4.5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ResDiam5 (mm)';
default{m,1}.entrystr = '4.0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'YDist (mm)';
default{m,1}.entrystr = '30';