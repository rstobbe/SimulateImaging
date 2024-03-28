%=========================================================
% 
%=========================================================

function [SCRPTipt,EFCT,err] = B0Analysis_v1b(SCRPTipt,EFCTipt)

Status2('busy','Get Off Resonance Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
EFCT.method = EFCTipt.Func;
EFCT.b0mapfunc = EFCTipt.('OffResfunc').Func;
EFCT.te = str2double(EFCTipt.('TE'));

%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
CallingLabel = EFCTipt.Struct.labelstr;
B0MAPipt = EFCTipt.('OffResfunc');
if isfield(EFCTipt,([CallingLabel,'_Data']))
    if isfield(EFCTipt.([CallingLabel,'_Data']),'OffResfunc_Data')
        B0MAPipt.('OffResfunc_Data') = EFCTipt.([CallingLabel,'_Data']).('OffResfunc_Data');
    end
end

%------------------------------------------
% Get Pre Processing Function Info
%------------------------------------------
func = str2func(EFCT.b0mapfunc);           
[SCRPTipt,B0MAP,err] = func(SCRPTipt,B0MAPipt);
if err.flag
    return
end

%------------------------------------------
% Return
%------------------------------------------
EFCT.B0MAP = B0MAP;


Status2('done','',2);
Status2('done','',3);


