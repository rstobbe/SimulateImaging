%==================================================================
% (v2a)
%    
%==================================================================

classdef EffectAdd_OneEffect_v2a < handle

properties (SetAccess = private)                   
    Method = 'EffectAdd_OneEffect_v2a'
    Effect1func
    EFCT1
    Panel = cell(0)
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [EFCT,err] = EffectAdd_OneEffect_v2a(EFCTipt)    
    err.flag = 0;

    EFCT.Effect1func = EFCTipt.('Effect1func').Func; 
    EFCT1ipt = EFCTipt.('Effect1func');
    CallingFunction = EFCTipt.Struct.labelstr;
    if isfield(EFCTipt,([CallingFunction,'_Data']))
        if isfield(EFCTipt.([CallingFunction,'_Data']),('Objectfunc_Data'))
            EFCT1ipt.Objectfunc_Data = EFCTipt.([CallingFunction,'_Data']).Objectfunc_Data;
        end
    end
    func = str2func(EFCT.Effect1func);                   
    EFCT.EFCT1 = func(EFCT1ipt); 
end 

%==================================================================
% PreAdd
%================================================================== 
function err = PreAdd(EFCT,SIMMETH)
    err.flag = 0;
    EFCT.EFCT1.AddPreEffect(SIMMETH);
end

%==================================================================
% PostAdd
%================================================================== 
function [SampDat,err] = PostAdd(EFCT,SIMMETH,STCH,SampDat0)
    err.flag = 0;
    SampDat = EFCT.EFCT1.AddPostEffect(SIMMETH,STCH,SampDat0);
    EFCT.Panel = EFCT.EFCT1.Panel; 
end
  

end
end






