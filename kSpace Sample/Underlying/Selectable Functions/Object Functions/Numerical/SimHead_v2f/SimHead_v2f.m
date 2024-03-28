%===========================================
% (v2f)
%       - flat 'cutoff' bottom (along z)
%===========================================

function [SCRPTipt,OB,err] = SimHead_v2f(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.HeadWid = str2double(OBipt.('HeadWid'));
OB.IoFov = str2double(OBipt.('IoFov'));


Status2('done','',2);
Status2('done','',3);

