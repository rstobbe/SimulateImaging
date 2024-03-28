%=========================================================
% 
%=========================================================

function [SCRPTipt,SIGDEC,err] = CSFModel_v1a(SCRPTipt,SIGDECipt)

Status2('busy','CSF model decay',2);
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


