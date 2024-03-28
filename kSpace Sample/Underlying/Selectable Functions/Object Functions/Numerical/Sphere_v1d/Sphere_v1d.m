%===========================================
% (v1d)
%       - ObMatSz Defined by ZF (above)
%       - Allow bigger object than FoV
%===========================================

function [SCRPTipt,OB,err] = Sphere_v1d(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.SphereDiam = str2double(OBipt.('SphereDiam'));

Status2('done','',2);
Status2('done','',3);

