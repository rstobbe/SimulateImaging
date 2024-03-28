%===========================================
% (v1d)
%     - add lowpass filter
%===========================================

function [SCRPTipt,B0MAP,err] = B0MapOffResSphere_v1d(SCRPTipt,B0MAPipt)

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

B0MAP.lpassfunc = B0MAPipt.('LowPassfunc').Func;

CallingLabel = B0MAPipt.Struct.labelstr;
%---------------------------------------------
% Get Working Structures from Sub Functions
%---------------------------------------------
LPASSipt = B0MAPipt.('LowPassfunc');
if isfield(B0MAPipt,([CallingLabel,'_Data']))
    if isfield(B0MAPipt.([CallingLabel,'_Data']),'LowPassfunc_Data')
        LPASSipt.('LowPassfunc_Data') = B0MAPipt.([CallingLabel,'_Data']).('LowPassfunc_Data');
    end
end
%------------------------------------------
% Get Filter Info
%------------------------------------------
func = str2func(B0MAP.lpassfunc);           
[SCRPTipt,LPASS,err] = func(SCRPTipt,LPASSipt);
if err.flag
    return
end
B0MAP.LPASS = LPASS;

Status2('done','',2);
Status2('done','',3);

