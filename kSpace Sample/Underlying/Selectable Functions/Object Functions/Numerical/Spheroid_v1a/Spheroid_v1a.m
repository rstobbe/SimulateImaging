%===========================================
% (v1a)
%       
%===========================================

function [SCRPTipt,OB,err] = Spheroid_v1a(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.SphereDiam = str2double(OBipt.('BaseDiam'));
OB.Elip = str2double(OBipt.('Elip'));
OB.Orient = OBipt.('Orient');

Status2('done','',2);
Status2('done','',3);

