%==================================================================
% (v2a)
%   
%==================================================================

classdef SigDec_MonoExp_v2a < handle

properties (SetAccess = private)                   
    Method = 'SigDec_MonoExp_v2a'
    T2
    Panel = cell(0);
    NormToOne
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIGDEC,err] = SigDec_MonoExp_v2a(SIGDECipt)    
    err.flag = 0;
    SIGDEC.T2 = str2double(SIGDECipt.('T2'));
    SIGDEC.NormToOne = SIGDECipt.('NormToOne');
end

%==================================================================
% AddPreEffect
%==================================================================  
function [err] = AddPreEffect(B0MAP,SIMMETH)
    err.flag = 0;
end
%==================================================================
% AddDecay
%==================================================================  
function [SampDat,err] = AddPostEffect(SIGDEC,SIMMETH,STCH,SampDat0)
    err.flag = 0;
    T2decay = exp(-STCH.SamplingTimeOnTrajectory/SIGDEC.T2);

    if ~isempty(STCH.SamplingPtAtCentre)
        if strcmp(SIGDEC.NormToOne,'Yes')
            T2decay = T2decay / T2decay(STCH.SamplingPtAtCentre);
        end
    end
    T2decaymat = repmat(T2decay,[STCH.NumTraj 1]);
    SampDat = T2decaymat .* SampDat0;       
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIGDEC.Panel(1,:) = {'','','Output'};
    SIGDEC.Panel(2,:) = {'Method',SIGDEC.Method,'Output'};
    SIGDEC.Panel(3,:) = {'T2',SIGDEC.T2,'Output'};
    SIGDEC.Panel(4,:) = {'NormToOne',SIGDEC.NormToOne,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end


