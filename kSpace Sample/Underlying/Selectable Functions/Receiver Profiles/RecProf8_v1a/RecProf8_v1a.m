%=========================================================
% (v1a)
%       - 
%=========================================================

function [SCRPTipt,RPROF,err] = RecProf8_v1a(SCRPTipt,RPROFipt)

Status2('busy','Load Receiver Profile Data',2);
Status2('done','',2);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
RPROF.method = RPROFipt.Func;

Status2('done','',2);
Status2('done','',3);




