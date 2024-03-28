%===========================================
% (v1a) 
%===========================================

function [SCRPTipt,OB,err] = SimMeovPhanFlexible_v1a(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.SphereDiam = str2double(OBipt.('SphereDiam'));
OB.ResDiam1 = str2double(OBipt.('ResDiam1'));
OB.ResDiam2 = str2double(OBipt.('ResDiam2'));
OB.ResDiam3 = str2double(OBipt.('ResDiam3'));
OB.ResDiam4 = str2double(OBipt.('ResDiam4'));
OB.ResDiam5 = str2double(OBipt.('ResDiam5'));
OB.YDist = str2double(OBipt.('YDist'));

Status2('done','',2);
Status2('done','',3);

