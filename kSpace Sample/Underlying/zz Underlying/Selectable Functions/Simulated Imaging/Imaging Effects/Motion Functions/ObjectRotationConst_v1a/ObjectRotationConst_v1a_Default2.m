%=========================================================
% 
%=========================================================

function [default] = ObjectRotationConst_v1a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'MotionType';
default{m,1}.entrystr = 'ShiftHalf';
default{m,1}.options = {'ShiftHalf','FullShift'};

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'RotX (deg)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'RotY (deg)';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'RotZ (deg)';
default{m,1}.entrystr = '0';