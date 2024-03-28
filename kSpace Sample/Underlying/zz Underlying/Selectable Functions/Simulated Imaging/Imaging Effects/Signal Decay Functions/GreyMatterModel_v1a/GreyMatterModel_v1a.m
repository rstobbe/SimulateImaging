%=========================================================
% 
%=========================================================

function [SCRPTipt,SIGDEC,err] = WhiteMatterModel_v1a(SCRPTipt,SIGDECipt)

Status2('busy','White Matter model decay',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
SIGDEC.method = SIGDECipt.Func;
SIGDEC.SysPostRfDel = str2double(SIGDECipt.('SysPostRfDel'));

Status2('done','',2);
Status2('done','',3);


