%=========================================================
% 
%=========================================================

function [EFCT,err] = B0Analysis_v1b_Func(EFCT,INPUT)

Status2('busy','Add B0 Effect',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
prepostsamp = INPUT.prepostsamp;
if isfield(INPUT,'KSMP')
    KSMP = INPUT.KSMP;
    SampDat = KSMP.SampDat;
end
B0MAP = EFCT.B0MAP;
OB = INPUT.OB;
IMP = INPUT.IMP;
clear INPUT;

%---------------------------------------------
% Create B0 Map
%---------------------------------------------
if strcmp(prepostsamp,'pre')
    func = str2func([EFCT.b0mapfunc,'_Func']); 
    INPUT.OB = OB;
    INPUT.IMP = IMP;
    [B0MAP,err] = func(B0MAP,INPUT);
    if err.flag
        return
    end
    clear INPUT;
    EFCT.B0map = B0MAP.map;
    B0MAP = rmfield(B0MAP,'map');
    EFCT.B0MAP = B0MAP;
end

%---------------------------------------------
% Add TE
%---------------------------------------------
IMP.samp = IMP.samp + EFCT.te;

%---------------------------------------------
% Return
%---------------------------------------------
if strcmp(prepostsamp,'pre')
    EFCT.IMP = IMP;
end
if strcmp(prepostsamp,'post')
    EFCT.SampDat = SampDat;
end

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'EffectAdd',EFCT.method,'Output'};
EFCT.Panel = [Panel;B0MAP.Panel];
EFCT.PanelOutput = cell2struct(EFCT.Panel,{'label','value','type'},2);

Status2('done','',2);
Status2('done','',3);
