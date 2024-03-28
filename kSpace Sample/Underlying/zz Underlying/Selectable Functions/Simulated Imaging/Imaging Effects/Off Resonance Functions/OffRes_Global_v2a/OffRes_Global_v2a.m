%==================================================================
% (v2a)
%   
%==================================================================

classdef OffRes_Global_v2a < handle

properties (SetAccess = private)                   
    Method = 'OffRes_Global_v2a'
    OffRes
    Panel = cell(0);
    NormToOne
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [OFFRES,err] = OffRes_Global_v2a(OFFRESipt)    
    err.flag = 0;
    OFFRES.OffRes = str2double(OFFRESipt.('OffResonance'));
end

%==================================================================
% AddPreEffect
%==================================================================  
function AddPreEffect(OFFRES,SIMMETH,STCH)
    % Dummy
end

%==================================================================
% AddPostEffect
%==================================================================  
function [SampDat,err] = AddPostEffect(OFFRES,SIMMETH,STCH,SampDat0)
    err.flag = 0;
    FreqRad = 2*pi*OFFRES.OffRes/1000;
    SigEvo = exp(1i*FreqRad*STCH.SamplingTimeOnTrajectory);
    SigEvomat = repmat(SigEvo.',[1 STCH.NumTraj]);
    SampDat = SigEvomat .* SampDat0;       
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    OFFRES.Panel(1,:) = {'','','Output'};
    OFFRES.Panel(2,:) = {'Method',OFFRES.Method,'Output'};
    OFFRES.Panel(3,:) = {'OffRes',OFFRES.OffRes,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end


