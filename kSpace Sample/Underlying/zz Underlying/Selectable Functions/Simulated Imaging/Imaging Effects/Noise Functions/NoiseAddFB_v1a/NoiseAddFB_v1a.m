%=========================================================
% 
%=========================================================

function [SCRPTipt,NOISE,err] = NoiseAddFB_v1a(SCRPTipt,NOISEipt)

Status2('busy','Get Noise Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
NOISE.method = NOISEipt.Func;
NOISE.noisepower = str2double(NOISEipt.('RelNoisePower'));
NOISE.averages = str2double(NOISEipt.('Averages'));

Status2('done','',2);
Status2('done','',3);


