%=========================================================
% 
%=========================================================

function [default] = ObjectTransConst_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'MotionType';
default{m,1}.entrystr = 'ShiftHalf';
default{m,1}.options = {'ShiftHalf','FullShift'};

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'TransX (mm)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'TransY (mm)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'TransZ (mm)';
default{m,1}.entrystr = '0';
