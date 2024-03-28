%===========================================
% (v2e)
%       - same as 'SimSmallerHead_v2d'
%===========================================

function [SCRPTipt,OB,err] = SimHead_v2e(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.HeadWid = str2double(OBipt.('HeadWid'));


Status2('done','',2);
Status2('done','',3);

