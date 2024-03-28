%===========================================
% (v1c)
%     - shifts
%===========================================

function [SCRPTipt,B0MAP,err] = B0MapOffResSphere_v1c(SCRPTipt,B0MAPipt)

Status2('done','B0Map Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
B0MAP.method = B0MAPipt.Func;
B0MAP.spherediam = str2double(B0MAPipt.('SphereDiam'));
B0MAP.offres = str2double(B0MAPipt.('OffRes'));
B0MAP.xshift = str2double(B0MAPipt.('XShift'));
B0MAP.yshift = str2double(B0MAPipt.('YShift'));
B0MAP.zshift = str2double(B0MAPipt.('ZShift'));

Status2('done','',2);
Status2('done','',3);

