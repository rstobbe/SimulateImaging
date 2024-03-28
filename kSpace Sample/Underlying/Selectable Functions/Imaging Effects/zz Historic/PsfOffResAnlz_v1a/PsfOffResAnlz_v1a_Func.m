%=========================================================
% 
%=========================================================

function [EFCT,err] = PsfOffResAnlz_v1a_Func(EFCT,INPUT)

Status2('busy','Add PSF Off-Resonance',2);
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
% Add Off-Resonance
%---------------------------------------------
if strcmp(prepostsamp,'post')
    samp = IMP.samp;  
    OffRes = exp(1i*2*pi*samp*EFCT.OffRes/1000); 
    SampDat = SampDat.*repmat(OffRes,IMP.PROJimp.nproj,1);
    EFCT.type = 'complex';
end

%---------------------------------------------
% Return
%---------------------------------------------
EFCT.SampDat = SampDat;
% EFCT.SIGDEC = SIGDEC;
% EFCT.Panel = SIGDEC.Panel;
% EFCT.PanelOutput = SIGDEC.PanelOutput;

Status2('done','',2);
Status2('done','',3);