%=========================================================
% 
%=========================================================

function [default] = Sample_Standard_v2a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'BaseMatrix';
default{m,1}.entrystr = 140;
mat = (10:10:1000).';
default{m,1}.options = mat2cell(mat,length(mat));