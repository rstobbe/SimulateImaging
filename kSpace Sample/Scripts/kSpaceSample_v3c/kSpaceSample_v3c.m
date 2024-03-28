%===========================================
% (v3b)
%       - facilitate object array
%===========================================

function [SCRPTipt,SCRPTGBL,err] = kSpaceSample_v3c(SCRPTipt,SCRPTGBL)

Status('busy','Sample kSpace');
Status2('done','',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Clear Naming
%---------------------------------------------
inds = strcmp('Sampling_Name',{SCRPTipt.labelstr});
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
if not(isfield(SCRPTGBL,'Imp_File_Data'))
    if isfield(SCRPTGBL.CurrentTree.('Imp_File').Struct,'selectedfile')
        file = SCRPTGBL.CurrentTree.('Imp_File').Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = '(Re) Load Imp_File';
            ErrDisp(err);
            return
        else
            Status2('busy','Load Imp_File',2);
            load(file);
            saveData.path = file;
            SCRPTGBL.('Imp_File_Data') = saveData;
        end
    else
        err.flag = 1;
        err.msg = '(Re) Load Imp_File';
        ErrDisp(err);
        return
    end
end

%---------------------------------------------
% Load Input
%---------------------------------------------
SAMP.method = SCRPTGBL.CurrentTree.Func;
SAMP.ObjectFunc = SCRPTGBL.CurrentTree.('Objectfunc').Func;
SAMP.SampleFunc = SCRPTGBL.CurrentTree.('Samplefunc').Func;
SAMP.EffectAddFunc = SCRPTGBL.CurrentTree.('EffectAddfunc').Func;

%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
OBipt = SCRPTGBL.CurrentTree.('Objectfunc');
if isfield(SCRPTGBL,('Objectfunc_Data'))
    OBipt.Objectfunc_Data = SCRPTGBL.Objectfunc_Data;
end
KSMPipt = SCRPTGBL.CurrentTree.('Samplefunc');
if isfield(SCRPTGBL,('Samplefunc_Data'))
    KSMPipt.Samplefunc_Data = SCRPTGBL.Samplefunc_Data;
end
EFCTipt = SCRPTGBL.CurrentTree.('EffectAddfunc');
if isfield(SCRPTGBL,('EffectAddfunc_Data'))
    EFCTipt.EffectAddfunc_Data = SCRPTGBL.EffectAddfunc_Data;
end

%------------------------------------------
% Get Object Function Info
%------------------------------------------
func = str2func(SAMP.ObjectFunc);           
[SCRPTipt,OB,err] = func(SCRPTipt,OBipt);
if err.flag
    return
end

%------------------------------------------
% Get Sampling Function Info
%------------------------------------------
func = str2func(SAMP.SampleFunc);           
[SCRPTipt,KSMP,KSMP_Data,err] = func(SCRPTipt,KSMPipt);
if err.flag
    return
end
SCRPTGBL.Samplefunc_Data = KSMP_Data;

%------------------------------------------
% Get Effect Function Info
%------------------------------------------
func = str2func(SAMP.EffectAddFunc);           
[SCRPTipt,EFCT,err] = func(SCRPTipt,EFCTipt);
if err.flag
    return
end

%---------------------------------------------
% Load Implementation
%---------------------------------------------
IMP = SCRPTGBL.Imp_File_Data.IMP;
SAMP.ImpFile = IMP.name;

%---------------------------------------------
% Sample k-Space
%---------------------------------------------
func = str2func([SAMP.method,'_Func']);
INPUT.IMP = IMP;
INPUT.OB = OB;
INPUT.KSMP = KSMP;
INPUT.EFCT = EFCT;
[SAMP,err] = func(INPUT,SAMP);
if err.flag
    return
end

%--------------------------------------------
% Output to TextBox
%--------------------------------------------
SAMP.ExpDisp = PanelStruct2Text(SAMP.PanelOutput);
global FIGOBJS
FIGOBJS.(SCRPTGBL.RWSUI.tab).Info.String = SAMP.ExpDisp;

%--------------------------------------------
% Return
%--------------------------------------------
name = inputdlg('Name Sampling:','Name Sampling',1,{['KSMP_',SAMP.OB.name]});
if isempty(name)
    SCRPTGBL.RWSUI.SaveGlobal = 'no';
    return
end
SAMP.name = name{1};
SAMP.OB.name = name{1}(6:end);

%---------------------------------------------
% Return
%---------------------------------------------
SCRPTipt(indnum).entrystr = SAMP.name;
SCRPTGBL.RWSUI.SaveVariables = SAMP;
SCRPTGBL.RWSUI.SaveVariableNames = 'SAMP';
SCRPTGBL.RWSUI.SaveGlobal = 'yes';
SCRPTGBL.RWSUI.SaveGlobalNames = SAMP.name;
SCRPTGBL.RWSUI.SaveScriptOption = 'yes';
SCRPTGBL.RWSUI.SaveScriptPath = 'outloc';
SCRPTGBL.RWSUI.SaveScriptName = SAMP.name;

Status('done','');
Status2('done','',2);
Status2('done','',3);
