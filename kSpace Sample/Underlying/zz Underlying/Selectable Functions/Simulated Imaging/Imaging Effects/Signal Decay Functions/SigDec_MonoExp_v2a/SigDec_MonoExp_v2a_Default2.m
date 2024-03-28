%=========================================================
% 
%=========================================================

function [default] = SigDec_MonoExp_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Input';
default{m,1}.labelstr = 'T2 (ms)';
default{m,1}.entrystr = '1';

m = m+1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'NormToOne';
default{m,1}.entrystr = 'Yes';
default{m,1}.options = {'No','Yes'};