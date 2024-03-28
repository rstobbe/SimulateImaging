%===========================================
% (v1b)
%   - shorter arms (as if folded onto stomach)
%===========================================

function [SCRPTipt,OB,err] = SimTorsoRich_v1b(SCRPTipt,OBipt)

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

