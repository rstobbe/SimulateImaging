%===========================================
% (v2f)
%    - include weighting term
%===========================================

function [SCRPTipt,OB,err] = SimHead23NaCSF_v2f(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.wgt = str2double(OBipt.('Weighting'));

Status2('done','',2);
Status2('done','',3);

