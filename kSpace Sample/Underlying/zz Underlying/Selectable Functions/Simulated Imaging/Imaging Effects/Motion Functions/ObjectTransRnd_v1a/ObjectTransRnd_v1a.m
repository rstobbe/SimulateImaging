%===========================================
% (v1a)
%       
%===========================================

function [SCRPTipt,TRANS,err] = ObjectTransRnd_v1a(SCRPTipt,TRANSipt)

Status2('busy','Get Translation Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
TRANS.method = TRANSipt.Func;
TRANS.transstdev = str2double(TRANSipt.('TransStdev'));

Status2('done','',2);
Status2('done','',3);

