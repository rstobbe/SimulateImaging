%==================================================================
% (v2a)
%    
%==================================================================

classdef EffectAdd_SigDecay_v2a < handle

properties (SetAccess = private)                   
    Method = ' EffectAdd_SigDecay_v2a'
    SigDecfunc
    SIGDEC
    Panel = cell(0)
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [EFCT,err] = EffectAdd_SigDecay_v2a(EFCTipt)    
    err.flag = 0;

    EFCT.SigDecfunc = EFCTipt.('SigDecfunc').Func; 
    SIGDECipt = EFCTipt.('SigDecfunc');
    CallingFunction = EFCTipt.Struct.labelstr;
    if isfield(EFCTipt,([CallingFunction,'_Data']))
        if isfield(EFCTipt.([CallingFunction,'_Data']),('Objectfunc_Data'))
            SIGDECipt.Objectfunc_Data = EFCTipt.([CallingFunction,'_Data']).Objectfunc_Data;
        end
    end
    func = str2func(EFCT.SigDecfunc);                   
    EFCT.SIGDEC = func(SIGDECipt); 
end 

%==================================================================
% PostAdd
%================================================================== 
function [SampDat,err] = PostAdd(EFCT,SIMMETH,STCH,SampDat0)
    err.flag = 0;
    SampDat = EFCT.SIGDEC.AddDecay(SIMMETH,STCH,SampDat0);
    EFCT.Panel = EFCT.SIGDEC.Panel; 
end
  

end
end






