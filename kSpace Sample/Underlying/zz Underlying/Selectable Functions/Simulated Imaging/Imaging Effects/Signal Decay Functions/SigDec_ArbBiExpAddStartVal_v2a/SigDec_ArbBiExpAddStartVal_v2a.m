%==================================================================
% (v2a)
%   
%==================================================================

classdef SigDec_ArbBiExpAddStartVal_v2a < handle

properties (SetAccess = private)                   
    Method = 'SigDec_ArbBiExpAddStartVal_v2a'
    T2f,T2s,StartVal,FracT2f
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIGDEC,err] = SigDec_ArbBiExpAddStartVal_v2a(SIGDECipt)    
    err.flag = 0;
    SIGDEC.FracT2f = str2double(SIGDECipt.('FracT2f'));
    SIGDEC.T2f = str2double(SIGDECipt.('T2f'));
    SIGDEC.T2s = str2double(SIGDECipt.('T2s'));
    SIGDEC.StartVal = str2double(SIGDECipt.('StartVal'));
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
    
    T2decay = SIGDEC.FracT2f*exp(-(STCH.SamplingTimeOnTrajectory)/SIGDEC.T2f) + (1-SIGDEC.FracT2f)*exp(-(STCH.SamplingTimeOnTrajectory)/SIGDEC.T2s);

    T2decay = T2decay * SIGDEC.StartVal;
    
    T2decaymat = repmat(T2decay,[STCH.NumTraj 1]);
    SampDat = T2decaymat .* SampDat0;       
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIGDEC.Panel(1,:) = {'','','Output'};
    SIGDEC.Panel(2,:) = {'Method',SIGDEC.Method,'Output'};
    SIGDEC.Panel(3,:) = {'T2f',SIGDEC.T2f,'Output'};
    SIGDEC.Panel(4,:) = {'FastFrac',SIGDEC.FracT2f,'Output'};
    SIGDEC.Panel(5,:) = {'T2s',SIGDEC.T2s,'Output'};
    SIGDEC.Panel(6,:) = {'StartVal',SIGDEC.StartVal,'Output'};

    
    Status2('done','',2);
    Status2('done','',3);
end


end
end


