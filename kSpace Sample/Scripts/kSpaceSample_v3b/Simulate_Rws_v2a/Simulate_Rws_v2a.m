%=========================================================
% (v2a) 
%       - accomodate new objects
%=========================================================

function [SCRPTipt,SCRPTGBL,err] = Simulate_Rws_v2a(SCRPTipt,SCRPTGBL)

Status('busy','Write ');
Status2('done','',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Clear Naming
%---------------------------------------------
inds = strcmp('Sim_Name',{SCRPTipt.labelstr});
indnum = find(inds==1);
if length(indnum) > 1
    indnum = indnum(SCRPTGBL.RWSUI.scrptnum);
end
SCRPTipt(indnum).entrystr = '';
setfunc = 1;
DispScriptParam(SCRPTipt,setfunc,SCRPTGBL.RWSUI.tab,SCRPTGBL.RWSUI.panelnum);

%---------------------------------------------
% Tests
%---------------------------------------------
if not(isfield(SCRPTGBL,'Recon_File_Data'))
    if isfield(SCRPTGBL.CurrentTree.('Recon_File').Struct,'selectedfile')
    file = SCRPTGBL.CurrentTree.('Recon_File').Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = '(Re) Load Recon_File - path no longer valid';
            ErrDisp(err);
            return
        else
            Status('busy','Load Trajectory Implementation');
            load(file);
            saveData.path = file;
            SCRPTGBL.('Recon_File_Data') = saveData;
        end
    else
        err.flag = 1;
        err.msg = '(Re) Load Recon_File';
        ErrDisp(err);
        return
    end
end

%---------------------------------------------
% Load Input
%---------------------------------------------
SIM.method = SCRPTGBL.CurrentTree.Func;
SIM.simmethfunc = SCRPTGBL.CurrentTree.SimMethfunc.Func;

%---------------------------------------------
% Load Implementation
%---------------------------------------------
WRT = SCRPTGBL.Recon_File_Data.WRT;

%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
SIMMETHipt = SCRPTGBL.CurrentTree.('SimMethfunc');
if isfield(SCRPTGBL,('SimMethfunc_Data'))
    SIMMETHipt.SimMethfunc_Data = SCRPTGBL.SimMethfunc_Data;
end

%---------------------------------------------
% Write
%---------------------------------------------
func = str2func(SIM.simmethfunc);           
[SIMMETH,err] = func(SIMMETHipt);
if err.flag
    return
end
err = SIMMETH.Simulate(WRT);
if err.flag
    return
end
props = properties(SIMMETH);
for n = 1:length(props)
    SIM.(props{n}) = SIMMETH.(props{n});
end

%--------------------------------------------
% Output to TextBox
%--------------------------------------------
global FIGOBJS
FIGOBJS.(SCRPTGBL.RWSUI.tab).Info.String = SIM.ExpDisp;

%--------------------------------------------
% Return
%--------------------------------------------
name = inputdlg('Name Sampling:','Sampling',1,{['KSMP_',SIM.name]});
if isempty(name)
    SCRPTGBL.RWSUI.KeepEdit = 'yes';
    SCRPTGBL.RWSUI.SaveGlobal = 'no';
    return
end
SIM.name = name{1};

SCRPTipt(indnum).entrystr = SIM.name;
SCRPTGBL.RWSUI.SaveVariables = SIM;
SCRPTGBL.RWSUI.SaveVariableNames = 'SAMP';            
SCRPTGBL.RWSUI.SaveGlobal = 'yes';
SCRPTGBL.RWSUI.SaveGlobalNames = SIM.name;
SCRPTGBL.RWSUI.SaveScriptOption = 'yes';
SCRPTGBL.RWSUI.SaveScriptPath = 'outloc';
SCRPTGBL.RWSUI.SaveScriptName = SIM.name;

Status('done','');
Status2('done','',2);
Status2('done','',3);

