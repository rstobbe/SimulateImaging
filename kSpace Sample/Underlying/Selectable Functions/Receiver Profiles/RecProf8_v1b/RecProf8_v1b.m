%=========================================================
% (v1b)
%       - Selection of Profile Drop-Off
%=========================================================

function [SCRPTipt,RPROF,err] = RecProf8_v1b(SCRPTipt,RPROFipt)

Status2('busy','Load Receiver Profile Data',2);
Status2('done','',2);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
RPROF.method = RPROFipt.Func;
RPROF.drofofffact = str2double(RPROFipt.('DropOffFact'));

Status2('done','',2);
Status2('done','',3);




