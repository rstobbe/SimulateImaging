%=========================================================
% 
%=========================================================

function [default] = SimResPhanSquares_v1b_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'OuterBox (mm)';
default{m,1}.entrystr = '160';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'OuterSig';
default{m,1}.entrystr = '0';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Cube1 (mm)';
default{m,1}.entrystr = '10.5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Cube2 (mm)';
default{m,1}.entrystr = '9';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Cube3 (mm)';
default{m,1}.entrystr = '7.5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Cube4 (mm)';
default{m,1}.entrystr = '6';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Cube5 (mm)';
default{m,1}.entrystr = '4.5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'Cube6 (mm)';
default{m,1}.entrystr = '3';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'YDist (mm)';
default{m,1}.entrystr = '15';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'YShift (mm)';
default{m,1}.entrystr = '10';