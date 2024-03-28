%=========================================================
% 
%=========================================================

function [default] = Sodium_T2_Default(TestNum)

m = 1;
default{m,1}.labelstyle = '0labellvl2'; 
default{m,1}.labelstr = 'T2f';
default{m,1}.entrystr = '1.0';
default{m,1}.entryvalue = 0;
default{m,1}.searchpath = '';
default{m,1}.buttonname = 'Edit';
default{m,1}.entrytype = 'Input';
default{m,1}.funcname = '';

m = m+1;
default{m,1}.labelstyle = '0labellvl2'; 
default{m,1}.labelstr = 'T2s';
default{m,1}.entrystr = '15';
default{m,1}.entryvalue = 0;
default{m,1}.searchpath = '';
default{m,1}.buttonname = 'Edit';
default{m,1}.entrytype = 'Input';
default{m,1}.funcname = '';

m = m+1;
default{m,1}.labelstyle = '0labellvl2'; 
default{m,1}.labelstr = 'TE';
default{m,1}.entrystr = '0.2';
default{m,1}.entryvalue = 0;
default{m,1}.searchpath = '';
default{m,1}.buttonname = 'Edit';
default{m,1}.entrytype = 'Input';
default{m,1}.funcname = '';