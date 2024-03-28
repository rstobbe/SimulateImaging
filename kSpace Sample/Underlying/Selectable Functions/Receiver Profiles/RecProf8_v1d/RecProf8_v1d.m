%=========================================================
% (v1d)
%       - Selection of Corner Inset
%=========================================================

function [SCRPTipt,RPROF,err] = RecProf8_v1d(SCRPTipt,RPROFipt)

Status2('busy','Load Receiver Profile Data',2);
Status2('done','',2);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
RPROF.method = RPROFipt.Func;
RPROF.drofofffact = str2double(RPROFipt.('DropOffFact'));
RPROF.xinset = str2double(RPROFipt.('Xinset'));
RPROF.yinset = str2double(RPROFipt.('Yinset'));
RPROF.zinset = str2double(RPROFipt.('Zinset'));

Status2('done','',2);
Status2('done','',3);




