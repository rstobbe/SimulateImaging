%=========================================================
% 
%=========================================================

function [default] = Simulate_Rws_v3a_Default2(SCRPTPATHS)

if strcmp(filesep,'\')
    simmethpath = [SCRPTPATHS.pioneerloc,'System Write\Underlying\Selectable Functions\WrtSys Functions\'];
elseif strcmp(filesep,'/')
end
simmethfunc = 'SimMeth_Basic_v3a';

m = 1;
default{m,1}.entrytype = 'OutputName';
default{m,1}.labelstr = 'Sim_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'ScriptName';
default{m,1}.labelstr = 'Script_Name';
default{m,1}.entrystr = '';

m = m+1;
default{m,1}.entrytype = 'RunExtFunc';
default{m,1}.labelstr = 'Recon_File';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Load';
default{m,1}.runfunc1 = 'LoadReconCur';
default{m,1}.(default{m,1}.runfunc1).curloc = SCRPTPATHS.outloc;
default{m,1}.runfunc2 = 'LoadReconDisp';
default{m,1}.(default{m,1}.runfunc2).defloc = SCRPTPATHS.outloc;

m = m+1;
default{m,1}.entrytype = 'ScrptFunc';
default{m,1}.labelstr = 'SimMethfunc';
default{m,1}.entrystr = simmethfunc;
default{m,1}.searchpath = simmethpath;
default{m,1}.path = [simmethpath,simmethfunc];

m = m+1;
default{m,1}.entrytype = 'RunScrptFunc';
default{m,1}.scrpttype = 'SystemSim';
default{m,1}.labelstr = 'SystemSim';
default{m,1}.entrystr = '';
default{m,1}.buttonname = 'Run';

