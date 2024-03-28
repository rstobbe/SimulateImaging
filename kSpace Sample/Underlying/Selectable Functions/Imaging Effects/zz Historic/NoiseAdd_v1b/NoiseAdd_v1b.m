%=========================================================
% 
%=========================================================

function [SCRPTipt,EFCT,err] = NoiseAdd_v1b(SCRPTipt,EFCTipt)

Status2('busy','Noise Add',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
EFCT.method = EFCTipt.Func;
EFCT.noisepower = str2double(EFCTipt.('NoisePower'));

Status2('done','',2);
Status2('done','',3);


