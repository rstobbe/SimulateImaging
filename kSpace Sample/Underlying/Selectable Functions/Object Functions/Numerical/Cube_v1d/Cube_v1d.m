%===========================================
% (v1d)
%       
%===========================================

function [SCRPTipt,OB,err] = Cube_v1d(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.CubeDim = str2double(OBipt.('CubeDim'));

Status2('done','',2);
Status2('done','',3);

