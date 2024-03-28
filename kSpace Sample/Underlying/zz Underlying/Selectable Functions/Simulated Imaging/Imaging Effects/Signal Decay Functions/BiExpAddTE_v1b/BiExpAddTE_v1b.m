%=========================================================
% 
%=========================================================

function [SCRPTipt,SIGDEC,err] = BiExpAddTE_v1b(SCRPTipt,SIGDECipt)

Status2('busy','Get BiExp Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
SIGDEC.method = SIGDECipt.Func;
SIGDEC.T2f = str2double(SIGDECipt.('T2f'));
SIGDEC.T2s = str2double(SIGDECipt.('T2s'));
SIGDEC.TE = str2double(SIGDECipt.('TE'));
SIGDEC.NormToOne = SIGDECipt.('NormToOne');

Status2('done','',2);
Status2('done','',3);


