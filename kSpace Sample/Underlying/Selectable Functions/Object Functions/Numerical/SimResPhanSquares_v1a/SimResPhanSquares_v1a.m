%===========================================
% (v1a) 
%===========================================

function [SCRPTipt,OB,err] = SimResPhanSquares_v1a(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.OuterBoxWid = str2double(OBipt.('OuterBox')); 
OB.CubeDes(1) = str2double(OBipt.('Cube1'));
OB.CubeDes(2) = str2double(OBipt.('Cube2'));
OB.CubeDes(3) = str2double(OBipt.('Cube3'));
OB.CubeDes(4) = str2double(OBipt.('Cube4'));
OB.CubeDes(5) = str2double(OBipt.('Cube5'));
OB.CubeDes(6) = str2double(OBipt.('Cube6'));
OB.YDist = str2double(OBipt.('YDist'));
OB.YShift = str2double(OBipt.('YShift'));

Status2('done','',2);
Status2('done','',3);

