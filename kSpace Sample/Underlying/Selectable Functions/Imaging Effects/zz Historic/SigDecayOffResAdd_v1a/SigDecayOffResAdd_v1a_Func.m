%=========================================================
% 
%=========================================================

function [EFCT,err] = SigDecayOffResAdd_v1a_Func(EFCT,INPUT)

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
SIGDEC = EFCT.SIGDEC;
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
    samp = IMP.samp;
    PROJimp = IMP.PROJimp;
    func = str2func([EFCT.sigdecfunc,'_Func']); 
    INPUT.samp = samp;
    INPUT.SampDat = SampDat;
    INPUT.PROJimp = PROJimp;
    [SIGDEC,err] = func(SIGDEC,INPUT);
    if err.flag
        return
    end
    clear INPUT;
    SampDat = SIGDEC.SampDat;
    
    FreqRad = 2*pi*EFCT.OffRes/1000;
    SigMod = exp(1i*FreqRad*samp);
    %-
    figure(1235123);
    plot(samp,real(SigMod));
    %-
    [DatMat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
    SigModMat = repmat(SigMod,[PROJimp.nproj 1]);
    SampDat = DatMat2Arr(DatMat.*SigModMat,PROJimp.nproj,PROJimp.npro);    
     
    %EFCT.type = 'real';
end


%---------------------------------------------
% Return
%---------------------------------------------
EFCT.SampDat = SampDat;
EFCT.SIGDEC = SIGDEC;
EFCT.Panel = SIGDEC.Panel;
EFCT.PanelOutput = SIGDEC.PanelOutput;

Status2('done','',2);
Status2('done','',3);