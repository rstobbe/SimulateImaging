%===========================================
% (v1a) 
%===========================================

function [SCRPTipt,OB,err] = SimMeovPhanFlexible_v2a(SCRPTipt,OBipt)

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
OB.ResDiam6 = str2double(OBipt.('ResDiam6'));
OB.ResDiam7 = str2double(OBipt.('ResDiam7'));
OB.ResDiam8 = str2double(OBipt.('ResDiam8'));
OB.ResDiam9 = str2double(OBipt.('ResDiam9'));
OB.SepDist = str2double(OBipt.('SepDist'));

Status2('done','',2);
Status2('done','',3);

