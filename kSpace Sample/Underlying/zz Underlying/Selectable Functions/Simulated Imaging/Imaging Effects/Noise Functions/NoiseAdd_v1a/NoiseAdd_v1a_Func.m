%=========================================================
% 
%=========================================================

function [NOISE,err] = NoiseAdd_v1a_Func(NOISE,INPUT)

Status2('busy','Add Noise',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
SampDat = INPUT.KSMP.SampDat;
noisepower = NOISE.noisepower;
clear INPUT;

%---------------------------------------------
% Add Noise
%---------------------------------------------
if length(SampDat(1,:)) == 1
    stdnoise = sqrt(noisepower);
    SampDat = SampDat + stdnoise*(randn(size(SampDat)) + 1i*randn(size(SampDat)));
else
    for n = 1:length(SampDat(1,:))
        stdnoise = sqrt(noisepower);
        SampDat(:,n) = SampDat(:,n) + stdnoise*(randn(size(SampDat(:,n))) + 1i*randn(size(SampDat(:,n))));
    end
end
    
%---------------------------------------------
% Return
%---------------------------------------------
NOISE.SampDat = SampDat;

Status2('done','',2);
Status2('done','',3);