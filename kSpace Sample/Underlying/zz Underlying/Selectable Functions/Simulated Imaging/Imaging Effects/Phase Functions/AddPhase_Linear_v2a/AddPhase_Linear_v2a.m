%==================================================================
% (v2a)
%   
%==================================================================

classdef AddPhase_Linear_v2a < handle

properties (SetAccess = private)                   
    Method = 'AddPhase_Linear_v2a'
    Start
    Periods
    Dimension
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [PHASE,err] = AddPhase_Linear_v2a(SIGDECipt)    
    err.flag = 0;
    PHASE.Start = str2double(SIGDECipt.('Start'));
    PHASE.Periods = str2double(SIGDECipt.('Periods'));
    PHASE.Dimension = SIGDECipt.('Dimension');
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
function [SampDat,err] = AddPostEffect(PHASE,SIMMETH,STCH,SampDat0)
    err.flag = 0;
    sz = SIMMETH.OB.ObMatSz;
    
    Phase = exp(-STCH.SamplingTimeOnTrajectory/PHASE.T2);

    if strcmp(PHASE.NormToOne,'Yes')
        T2decay = T2decay / T2decay(STCH.SamplingPtAtCentre);
    end
    T2decaymat = repmat(T2decay.',[1 STCH.NumTraj]);
    SampDat = T2decaymat .* SampDat0;       
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    PHASE.Panel(1,:) = {'','','Output'};
    PHASE.Panel(2,:) = {'Method',PHASE.Method,'Output'};
    PHASE.Panel(3,:) = {'T2',PHASE.T2,'Output'};
    PHASE.Panel(4,:) = {'NormToOne',PHASE.NormToOne,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end


