%===========================================
% (v1a)
%     
%===========================================

function [SCRPTipt,B0MAP,err] = B0MapOffResSphereRim_v1a(SCRPTipt,B0MAPipt)

Status2('done','B0Map Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
B0MAP.method = B0MAPipt.Func;
B0MAP.spherediam = str2double(B0MAPipt.('SphereDiam'));
B0MAP.rimthick = str2double(B0MAPipt.('RimThick'));
B0MAP.offres = str2double(B0MAPipt.('OffRes'));

Status2('done','',2);
Status2('done','',3);

