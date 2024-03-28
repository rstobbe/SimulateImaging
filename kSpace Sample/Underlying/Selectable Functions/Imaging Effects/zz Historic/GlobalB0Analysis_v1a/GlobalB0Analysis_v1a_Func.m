%=========================================================
% 
%=========================================================

function [EFCT,err] = GlobalB0Analysis_v1a_Func(EFCT,INPUT)

Status2('busy','Add Imaging Effect',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
if isfield(INPUT,'prepostsamp')
    prepostsamp = INPUT.prepostsamp;
else
    prepostsamp = 'post';
end
if isfield(INPUT,'KSMP')
    KSMP = INPUT.KSMP;
    SampDat = KSMP.SampDat;
end
if isfield(INPUT,'SampDat')
    SampDat = INPUT.SampDat;
end
IMP = INPUT.IMP;
clear INPUT;

%---------------------------------------------
% Do Nothing Before Sampling
%---------------------------------------------
if strcmp(prepostsamp,'pre')
    return
end

%---------------------------------------------
% Add Signal Decay
%---------------------------------------------
if strcmp(prepostsamp,'post')
    PROJimp = IMP.PROJimp;
    FreqRad = 2*pi*EFCT.OffRes/1000;
    %samp = IMP.samp + SIGDEC.SysPostRfDel
    samp = IMP.samp;
    T2decay = exp(1i*FreqRad*samp);
    %-
    figure(1235123);
    plot(samp,real(T2decay));
    %-
    [Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
    T2decaymat = repmat(T2decay,[PROJimp.nproj 1]);
    EFCT.SampDat = DatMat2Arr(Datmat.*T2decaymat,PROJimp.nproj,PROJimp.npro);
end

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'EffectAdd',EFCT.method,'Output'};
EFCT.Panel = Panel;
EFCT.PanelOutput = cell2struct(EFCT.Panel,{'label','value','type'},2);

Status2('done','',2);
Status2('done','',3);