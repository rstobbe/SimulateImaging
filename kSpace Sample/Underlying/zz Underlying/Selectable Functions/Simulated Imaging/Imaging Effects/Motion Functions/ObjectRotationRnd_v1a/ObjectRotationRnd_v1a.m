%=========================================================
% 
%=========================================================

function [SCRPTipt,ROT,err] = ObjectRotationRnd_v1a(SCRPTipt,ROTipt)

Status2('busy','Get Rotation Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
ROT.method = ROTipt.Func;
ROT.rotstdev = str2double(ROTipt.('RotStdev'));

Status2('done','',2);
Status2('done','',3);


