%=========================================================
% 
%=========================================================

function [SCRPTipt,SIGDEC,err] = MonoExpAdd_v1a(SCRPTipt,SIGDECipt)

Status2('busy','Get MonoExp Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
SIGDEC.method = SIGDECipt.Func;
SIGDEC.T2 = str2double(SIGDECipt.('T2'));

Status2('done','',2);
Status2('done','',3);


