%=========================================================
% 
%=========================================================

function [SCRPTipt,KSHFT,err] = kShiftConst_v1a(SCRPTipt,KSHFTipt)

Status2('busy','Get k-Shift Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
KSHFT.method = KSHFTipt.Func;
KSHFT.shiftX = str2double(KSHFTipt.('ShiftX'));
KSHFT.shiftY = str2double(KSHFTipt.('ShiftY'));
KSHFT.shiftZ = str2double(KSHFTipt.('ShiftZ'));

Status2('done','',2);
Status2('done','',3);


