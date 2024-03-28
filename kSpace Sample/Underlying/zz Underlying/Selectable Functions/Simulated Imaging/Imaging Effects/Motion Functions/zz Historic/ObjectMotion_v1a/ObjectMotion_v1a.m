%===========================================
% (v1a)
%       
%===========================================

function [SCRPTipt,MOT,err] = ObjectMotion_v1a(SCRPTipt,MOTipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
MOT = struct();
MOT.Theta = str2double(MOTipt.('Theta'));
MOT.Phi = str2double(MOTipt.('Phi'));
MOT.Psi = str2double(MOTipt.('Psi'));
MOT.X = str2double(MOTipt.('X'));
MOT.Y = str2double(MOTipt.('Y'));
MOT.Z = str2double(MOTipt.('Z'));

Status2('done','',2);
Status2('done','',3);

