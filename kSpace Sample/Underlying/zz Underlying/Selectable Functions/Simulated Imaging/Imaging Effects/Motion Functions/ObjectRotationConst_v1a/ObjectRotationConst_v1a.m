%=========================================================
% 
%=========================================================

function [SCRPTipt,ROT,err] = ObjectRotationConst_v1a(SCRPTipt,ROTipt)

Status2('busy','Get Rotation Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
ROT.method = ROTipt.Func;
ROT.mottype = ROTipt.('MotionType');
ROT.rotx = str2double(ROTipt.('RotX'));
ROT.roty = str2double(ROTipt.('RotY'));
ROT.rotz = str2double(ROTipt.('RotZ'));

Status2('done','',2);
Status2('done','',3);


