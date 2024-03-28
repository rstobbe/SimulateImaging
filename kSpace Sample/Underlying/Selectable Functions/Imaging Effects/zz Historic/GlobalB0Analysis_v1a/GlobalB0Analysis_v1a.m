%=========================================================
% 
%=========================================================

function [SCRPTipt,EFCT,err] = SigDecayAdd_v1a(SCRPTipt,EFCTipt)

Status2('busy','Add Signal Decay',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
EFCT.method = EFCTipt.Func;
EFCT.OffRes = str2double(EFCTipt.OffResonance);

Status2('done','',2);
Status2('done','',3);


