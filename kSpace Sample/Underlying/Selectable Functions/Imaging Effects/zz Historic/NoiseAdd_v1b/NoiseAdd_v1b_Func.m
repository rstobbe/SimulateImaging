%=========================================================
% 
%=========================================================

function [EFCT,err] = NoiseAdd_v1b_Func(EFCT,INPUT)

Status2('busy','Add Noise',2);
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
clear INPUT;

%---------------------------------------------
% Return
%---------------------------------------------
if strcmp(prepostsamp,'post')
    figure(3456234);
    plot(abs(SampDat));
    stdnoise = sqrt(EFCT.noisepower);

    SampDat = SampDat + stdnoise*(randn(size(SampDat)) + 1i*randn(size(SampDat)));

    EFCT.SampDat = SampDat;
    EFCT.type = 'real';
end

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'EffectAdd',EFCT.method,'Output'};
Panel(3,:) = {'NoisePower',EFCT.noisepower,'Output'};
EFCT.Panel = Panel;
EFCT.PanelOutput = cell2struct(EFCT.Panel,{'label','value','type'},2);

Status2('done','',2);
Status2('done','',3);