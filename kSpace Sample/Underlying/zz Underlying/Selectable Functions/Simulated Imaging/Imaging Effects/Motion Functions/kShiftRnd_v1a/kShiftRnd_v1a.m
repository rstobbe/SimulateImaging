%=========================================================
% 
%=========================================================

function [SCRPTipt,KSHFT,err] = kShiftRnd_v1a(SCRPTipt,KSHFTipt)

Status2('busy','Get k-Shift Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
KSHFT.method = KSHFTipt.Func;
KSHFT.shiftstdev = str2double(KSHFTipt.('ShiftStdev'));

Status2('done','',2);
Status2('done','',3);


