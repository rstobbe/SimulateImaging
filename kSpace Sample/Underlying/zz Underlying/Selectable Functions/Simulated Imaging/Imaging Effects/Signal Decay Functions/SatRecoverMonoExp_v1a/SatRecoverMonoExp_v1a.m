%=========================================================
% 
%=========================================================

function [SCRPTipt,SIGDEC,err] = SatRecoverMonoExp_v1a(SCRPTipt,SIGDECipt)

Status2('busy','Get MonoExp Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
SIGDEC.method = SIGDECipt.Func;
SIGDEC.T1 = str2double(SIGDECipt.('T1'));
SIGDEC.TR = str2double(SIGDECipt.('TR'));
SIGDEC.Start = str2double(SIGDECipt.('Start'));

Status2('done','',2);
Status2('done','',3);


