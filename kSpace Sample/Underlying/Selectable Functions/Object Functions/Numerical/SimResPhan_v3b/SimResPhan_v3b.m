%===========================================
% (v3a)
%       - ObMatSz Defined by ZF (above)    
%===========================================

function [SCRPTipt,OB,err] = SimResPhan_v3b(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.SphereDiam = str2double(OBipt.('SphereDiam'));
OB.ResDiam = str2double(OBipt.('ResDiam'));

Status2('done','',2);
Status2('done','',3);

