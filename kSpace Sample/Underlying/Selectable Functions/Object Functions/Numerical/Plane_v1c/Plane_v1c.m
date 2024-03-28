%===========================================
% (v1c)
%       - FoV same as trajectory 
%===========================================

function [SCRPTipt,OB,err] = Plane_v1c(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.thk = str2double(OBipt.('Thick'));
OB.len = str2double(OBipt.('Length'));

Status2('done','',2);
Status2('done','',3);

