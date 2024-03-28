%===========================================
% (v1d)
%       
%===========================================

function [SCRPTipt,OB,err] = Box_v1d(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.XDim = str2double(OBipt.('XDim'));
OB.YDim = str2double(OBipt.('YDim'));
OB.ZDim = str2double(OBipt.('ZDim'));

Status2('done','',2);
Status2('done','',3);

