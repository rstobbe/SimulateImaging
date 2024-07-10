%==================================================================
% (v2b)
%   - update for external run
%==================================================================

classdef EffectAdd_NoEffect_v2b < handle

properties (SetAccess = private)                   
    Method = 'EffectAdd_NoEffect_v2b'
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function EFCT = EffectAdd_NoEffect_v2b()    
end

%==================================================================
% InitViaCompass
%==================================================================  
function InitViaCompass(EFCT,EFCTipt)    
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






