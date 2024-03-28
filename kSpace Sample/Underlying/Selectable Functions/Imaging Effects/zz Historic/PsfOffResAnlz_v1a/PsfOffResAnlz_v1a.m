%=========================================================
% 
%=========================================================

function [SCRPTipt,EFCT,err] = PsfOffResAnlz_v1a(SCRPTipt,EFCTipt)

Status2('busy','Add Signal Decay',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
EFCT.method = EFCTipt.Func;
EFCT.OffRes = str2double(EFCTipt.('OffRes'));


Status2('done','',2);
Status2('done','',3);


