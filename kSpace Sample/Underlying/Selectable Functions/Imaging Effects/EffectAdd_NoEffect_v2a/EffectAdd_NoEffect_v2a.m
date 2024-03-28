%==================================================================
% (v2a)
%   
%==================================================================

classdef EffectAdd_NoEffect_v2a < handle

properties (SetAccess = private)                   
    Method = 'EffectAdd_NoEffect_v2a'
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [EFCT,err] = EffectAdd_NoEffect_v2a(EFCTipt)    
    err.flag = 0;
end

%==================================================================
% PreAdd
%================================================================== 
function err = PreAdd(EFCT,SIMMETH)
    err.flag = 0;
end

%==================================================================
% PostAdd
%================================================================== 
function [SampDat0,err] = PostAdd(EFCT,SIMMETH,STCH,SampDat0)
    err.flag = 0;
end
  

end
end






