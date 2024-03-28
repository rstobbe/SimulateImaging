%===========================================
% (v1a)
%       
%===========================================

function [SCRPTipt,OB,err] = SplitCyllinder_v1a(SCRPTipt,OBipt)

Status2('done','Object Function Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
OB.method = OBipt.Func;
OB.ObMatSz = str2double(OBipt.('ObMatSz'));
OB.Diam = str2double(OBipt.('Diam'));
OB.Length = str2double(OBipt.('Length'));
OB.Split = str2double(OBipt.('Split'));

Status2('done','',2);
Status2('done','',3);

