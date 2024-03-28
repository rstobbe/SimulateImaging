%===========================================
% (v2a)
%       - non-zero Square
%===========================================

function [SCRPTipt,OB,err] = SimResPhan_v2a(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.ObMatSz = str2double(OBipt.('ObMatSz'));
OB.ObFoV = str2double(OBipt.('ObDim'));

Status2('done','',2);
Status2('done','',3);

