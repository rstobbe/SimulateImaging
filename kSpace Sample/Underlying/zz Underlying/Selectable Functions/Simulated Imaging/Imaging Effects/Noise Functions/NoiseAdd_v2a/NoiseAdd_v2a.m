%==================================================================
% (v2a)
%   
%==================================================================

classdef NoiseAdd_v2a < handle

properties (SetAccess = private)                   
    Method = 'NoiseAdd_v2a'
    NoisePower
    Panel = cell(0);
    NormToOne
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [OFFRES,err] = NoiseAdd_v2a(OFFRESipt)    
    err.flag = 0;
    OFFRES.NoisePower = str2double(OFFRESipt.('NoisePower'));
end

%==================================================================
% AddPreEffect
%==================================================================  
function AddPreEffect(NOISE,SIMMETH,STCH)
    % Dummy
end

%==================================================================
% AddPostEffect
%==================================================================  
function [SampDat,err] = AddPostEffect(NOISE,SIMMETH,STCH,SampDat0)
    err.flag = 0;
    stdnoise = sqrt(NOISE.NoisePower);
    SampDat = SampDat0 + stdnoise*(randn(size(SampDat0)) + 1i*randn(size(SampDat0)));    
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    NOISE.Panel(1,:) = {'','','Output'};
    NOISE.Panel(2,:) = {'Method',NOISE.Method,'Output'};
    NOISE.Panel(3,:) = {'NoisePower',NOISE.NoisePower,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end


