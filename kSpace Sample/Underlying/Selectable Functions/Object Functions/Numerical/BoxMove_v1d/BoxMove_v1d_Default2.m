%=========================================================
% 
%=========================================================

function [default] = BoxMove_v1d_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'XDim (mm)';
default{m,1}.entrystr = '130';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'YDim (mm)';
default{m,1}.entrystr = '30';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ZDim (mm)';
default{m,1}.entrystr = '130';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'XOff (mm)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'YOff (mm)';
default{m,1}.entrystr = '50';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ZOff (mm)';
default{m,1}.entrystr = '0';
