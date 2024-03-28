%=========================================================
% 
%=========================================================

function [SCRPTipt,EFCT,err] = SigDecayOffResAdd_v1a(SCRPTipt,EFCTipt)

Status2('busy','Add Signal Decay and Off-Resonance',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
EFCT.method = EFCTipt.Func;
EFCT.sigdecfunc = EFCTipt.('SigDecfunc').Func;
EFCT.OffRes = str2double(EFCTipt.('OffResonance'));

%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
CallingLabel = EFCTipt.Struct.labelstr;
SIGDECipt = EFCTipt.('SigDecfunc');
if isfield(EFCTipt,([CallingLabel,'_Data']))
    if isfield(EFCTipt.([CallingLabel,'_Data']),'SigDecfunc_Data')
        SIGDECipt.('SigDecfunc_Data') = EFCTipt.([CallingLabel,'_Data']).('SigDecfunc_Data');
    end
end

%------------------------------------------
% Get Pre Processing Function Info
%------------------------------------------
func = str2func(EFCT.sigdecfunc);           
[SCRPTipt,SIGDEC,err] = func(SCRPTipt,SIGDECipt);
if err.flag
    return
end

%------------------------------------------
% Return
%------------------------------------------
EFCT.SIGDEC = SIGDEC;


Status2('done','',2);
Status2('done','',3);


