%=========================================================
% 
%=========================================================

function [NOISE,err] = NoiseAddFB_v1a_Func(NOISE,INPUT)

Status2('busy','Add Noise',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
SampBW = INPUT.IMP.TSMP.samplingBW/1000;
SampDat = INPUT.KSMP.SampDat;
noisepower = NOISE.noisepower;
aves = NOISE.averages;
clear INPUT;

%---------------------------------------------
% Add Noise
%---------------------------------------------
if length(SampDat(1,:)) == 1
    SampDat = SampDat + (1/(sqrt(aves)))*sqrt(SampBW)*sqrt(noisepower)*(randn(size(SampDat)) + 1i*randn(size(SampDat)));
else
    for n = 1:length(SampDat(1,:))
        SampDat(:,n) = SampDat(:,n) + (1/(sqrt(aves)))*sqrt(SampBW)*sqrt(noisepower)*(randn(size(SampDat(:,n))) + 1i*randn(size(SampDat(:,n))));
    end
end
    
%---------------------------------------------
% Return
%---------------------------------------------
NOISE.SampDat = SampDat;

Status2('done','',2);
Status2('done','',3);