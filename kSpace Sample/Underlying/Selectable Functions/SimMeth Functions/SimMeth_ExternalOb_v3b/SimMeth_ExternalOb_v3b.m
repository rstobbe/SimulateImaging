%==================================================================
% (v3b)
%       - Update for external initiation. 
%==================================================================

classdef SimMeth_ExternalOb_v3b < handle

properties (SetAccess = private)                   
    Method = 'SimMeth_ExternalOb_v3b'
    SimObjectfunc
    SaveSimImages
    Samplefunc
    KSMP
    EffectAddfunc
    EFCT
    SampDat
    TrajName
    GridMatrix
    DataDims
    Panel = cell(0)
    PanelOutput
    ExpDisp
end
properties (SetAccess = public)    
    name
    path
    saveSCRPTcellarray
end

methods 
 
%==================================================================
% Constructor
%==================================================================  
function SIMMETH = SimMeth_ExternalOb_v3b()    
end

%==================================================================
% SetTrajName
%==================================================================  
function SetTrajName(SIMMETH,TrajName)             
    SIMMETH.TrajName = TrajName;  
end

%==================================================================
% SetSample
%==================================================================  
function SetSample(SIMMETH,Sample)
    func = str2func(Sample);                   
    SIMMETH.KSMP = func();  
end

%==================================================================
% SetEffectAdd
%==================================================================  
function SetEffectAdd(SIMMETH,Effect)
    func = str2func(Effect);                   
    SIMMETH.EFCT = func();  
end

%==================================================================
% Simulate
%================================================================== 
function err = Simulate(SIMMETH,STCH)
  
    %---------------------------------------------
    % Effect Add
    %---------------------------------------------
    err = SIMMETH.EFCT.PreAdd(SIMMETH);        
    if err.flag
        return
    end      
   
    Status2('busy','k-Space Sample',2);
    for n = 1:length(STCH)

        %---------------------------------------------
        % kSpaceSample
        %---------------------------------------------
        [SampDat0,err] = SIMMETH.KSMP.kSpaceSample(STCH{n});
        if err.flag
            return
        end

        %---------------------------------------------
        % Effect Add
        %---------------------------------------------
        [SIMMETH.SampDat{n},err] = SIMMETH.EFCT.PostAdd(SIMMETH,STCH{n},SampDat0);
        
    end
    
    SIMMETH.GridMatrix = SIMMETH.KSMP.GridMatrix;
    SIMMETH.DataDims = STCH{1}.DataDims;
    
    %---------------------------------------------
    % Panel
    %---------------------------------------------
    Panel0(1,:) = {'','','Output'};
    Panel0(2,:) = {'ReconFile',STCH{1}.name,'Output'};
    SIMMETH.Panel = [Panel0;SIMMETH.EFCT.Panel]; 
    SIMMETH.PanelOutput = cell2struct(SIMMETH.Panel,{'label','value','type'},2);
    SIMMETH.ExpDisp = PanelStruct2Text(SIMMETH.PanelOutput);
    
    Status2('done','',1);
    Status2('done','',2);
    Status2('done','',3);

end


end
end






