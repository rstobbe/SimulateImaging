%===========================================
% (v1a)
%     
%===========================================

function [SCRPTipt,B0MAP,err] = B0MapOffResCircle_v1a(SCRPTipt,B0MAPipt)

Status2('done','B0Map Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
B0MAP.method = B0MAPipt.Func;
B0MAP.circlediam = str2double(B0MAPipt.('CircleDiam'));
B0MAP.offres = str2double(B0MAPipt.('OffRes'));

Status2('done','',2);
Status2('done','',3);

