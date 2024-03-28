%=========================================================
% 
%=========================================================

function [SCRPTipt,T2,err] = T2starAdd_v1a(SCRPTipt,T2ipt)

Status2('busy','Get T2star Decay Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
T2.method = T2ipt.Func;
T2.T2star = str2double(T2ipt.('T2star'));

Status2('done','',2);
Status2('done','',3);


