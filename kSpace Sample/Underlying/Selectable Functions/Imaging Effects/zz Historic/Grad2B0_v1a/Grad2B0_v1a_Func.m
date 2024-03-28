%=========================================================
% 
%=========================================================

function [EFCT,err] = Grad2B0_v1a_Func(EFCT,INPUT)

Status2('busy','Add Imaging Effect',2);
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
IMP = INPUT.IMP;
clear INPUT;

%---------------------------------------------
% Do Nothing Before Sampling
%---------------------------------------------
if strcmp(prepostsamp,'pre')
    return
end

%---------------------------------------------
% Sample
%---------------------------------------------
if strcmp(prepostsamp,'post')
    PROJimp = IMP.PROJimp;
    gseg = IMP.GQNT.gseg;
    Gx = IMP.Grecon(:,:,1);
    %Foff = Gx*100;
    Foff = ones(size(Gx))*100;
    PhaseInc = 2*pi*Foff*gseg/1000;
    Phase = cumsum(PhaseInc);
    iPhase = interp1((gseg:gseg:gseg*(length(Gx))),Phase,(PROJimp.dwell:PROJimp.dwell:PROJimp.tro));
    SampDat = SampDat.*exp(1i*iPhase).';
end

%---------------------------------------------
% Return
%---------------------------------------------
EFCT.SampDat = SampDat;

Status2('done','',2);
Status2('done','',3);