%=========================================================
% 
%=========================================================

function [default] = B0MapOffResSphere_v1d_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    filtpath = [SCRPTPATHS.voyagerloc,'Image Processing\Underlying\Selectable Functions\Filter Image\Low Pass\'];
elseif strcmp(filesep,'/')
end
filtfunc = 'LowPassFilterKaiser3D_v1a';

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'SphereDiam (mat)';
default{m,1}.entrystr = '20';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'OffRes (Hz)';
default{m,1}.entrystr = '50';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'XShift (mat)';
default{m,1}.entrystr = '5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'YShift (mat)';
default{m,1}.entrystr = '5';

m = m+1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'ZShift (mat)';
default{m,1}.entrystr = '5';

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'LowPassfunc';
default{m,1}.entrystr = filtfunc;
default{m,1}.searchpath = filtpath;
default{m,1}.path = [filtpath,filtfunc];