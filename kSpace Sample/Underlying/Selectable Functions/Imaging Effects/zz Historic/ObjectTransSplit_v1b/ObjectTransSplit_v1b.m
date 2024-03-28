%===========================================
% (v1b)
%     - move up a level  
%===========================================

function [SCRPTipt,TRANS,err] = ObjectTransSplit_v1b(SCRPTipt,TRANSipt)

Status2('busy','Get Translation Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
TRANS.method = TRANSipt.Func;
TRANS.transx = str2double(TRANSipt.('TransX'));
TRANS.transy = str2double(TRANSipt.('TransY'));
TRANS.transz = str2double(TRANSipt.('TransZ'));

Status2('done','',2);
Status2('done','',3);

