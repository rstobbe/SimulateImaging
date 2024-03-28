%=========================================================
% 
%=========================================================

function [SCRPTipt,EFCT,err] = NoEffect_v1a(SCRPTipt,EFCTipt)

Status2('busy','Get Effect Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
EFCT.method = EFCTipt.Func;

Status2('done','',2);
Status2('done','',3);


