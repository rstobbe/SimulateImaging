%===========================================
% (v1c)
%       - ObMatSz Defined by ZF (above)
%       - Allow bigger object than FoV
%===========================================

function [SCRPTipt,OB,err] = Cyllinder_v1c(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.Diam = str2double(OBipt.('Diam'));
OB.Length = str2double(OBipt.('Length'));
OB.Orient = OBipt.('Orient');

Status2('done','',2);
Status2('done','',3);

