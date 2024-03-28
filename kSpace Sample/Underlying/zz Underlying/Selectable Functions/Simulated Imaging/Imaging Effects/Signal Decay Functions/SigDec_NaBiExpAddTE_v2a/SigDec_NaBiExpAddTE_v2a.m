%==================================================================
% (v2a)
%   
%==================================================================

classdef SigDec_NaBiExpAddTE_v2a < handle

properties (SetAccess = private)                   
    Method = 'SigDec_NaBiExpAddTE_v2a'
    T2f,T2s,TE
    Panel = cell(0);
    NormToOne
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIGDEC,err] = SigDec_NaBiExpAddTE_v2a(SIGDECipt)    
    err.flag = 0;
    SIGDEC.T2f = str2double(SIGDECipt.('T2f'));
    SIGDEC.T2s = str2double(SIGDECipt.('T2s'));
    SIGDEC.TE = str2double(SIGDECipt.('TE'));
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
    
    T2decay = 0.6*exp(-(STCH.SamplingTimeOnTrajectory+SIGDEC.TE)/SIGDEC.T2f) + 0.4*exp(-(STCH.SamplingTimeOnTrajectory+SIGDEC.TE)/SIGDEC.T2s);

    if strcmp(SIGDEC.NormToOne,'Yes')
        %T2decay = T2decay / T2decay(STCH.SamplingPtAtCentre);
        T2decay = T2decay / T2decay(1);
    end
    %T2decaymat = repmat(T2decay.',[1 STCH.NumTraj]);
    T2decaymat = repmat(T2decay,[STCH.NumTraj 1]);
    SampDat = T2decaymat .* SampDat0;       
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIGDEC.Panel(1,:) = {'','','Output'};
    SIGDEC.Panel(2,:) = {'Method',SIGDEC.Method,'Output'};
    SIGDEC.Panel(3,:) = {'T2f',SIGDEC.T2f,'Output'};
    SIGDEC.Panel(4,:) = {'T2s',SIGDEC.T2s,'Output'};
    SIGDEC.Panel(5,:) = {'TE',SIGDEC.TE,'Output'};
    SIGDEC.Panel(6,:) = {'NormToOne',SIGDEC.NormToOne,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end


