%=========================================================
% 
%=========================================================

function [default] = kSampGrdSimCudaOffRes_v3a_Default2(SCRPTPATHS)

m = 1;
default{m,1}.entrytype = 'Choose';
default{m,1}.labelstr = 'BaseMatrix';
default{m,1}.entrystr = 100;
mat = (10:10:500).';
default{m,1}.options = mat2cell(mat,length(mat));