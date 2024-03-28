%=========================================================
% 
%=========================================================

function [SCRPTipt,NOISE,err] = NoiseAdd_v1a(SCRPTipt,NOISEipt)

Status2('busy','Get Noise Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
NOISE.method = NOISEipt.Func;
NOISE.noisepower = str2double(NOISEipt.('NoisePower'));

Status2('done','',2);
Status2('done','',3);


