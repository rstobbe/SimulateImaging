%===========================================
% (v1a)
%===========================================

function [SCRPTipt,OB,err] = SimTorso_v1a(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;

Status2('done','',2);
Status2('done','',3);

