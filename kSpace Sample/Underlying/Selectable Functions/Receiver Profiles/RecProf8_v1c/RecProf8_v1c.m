%=========================================================
% (v1c)
%       - Selection of Corner Inset
%=========================================================

function [SCRPTipt,RPROF,err] = RecProf8_v1c(SCRPTipt,RPROFipt)

Status2('busy','Load Receiver Profile Data',2);
Status2('done','',2);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
RPROF.method = RPROFipt.Func;
RPROF.drofofffact = str2double(RPROFipt.('DropOffFact'));
RPROF.cornerinset = str2double(RPROFipt.('CornerInset'));

Status2('done','',2);
Status2('done','',3);




