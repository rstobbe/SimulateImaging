%==================================================================
% (v3b)
%       - Update for external initiation. 
%==================================================================

classdef SimMeth_Basic_v3b < handle

properties (SetAccess = private)                   
    Method = 'SimMeth_Basic_v3b'
    SimObjectfunc
    SaveSimImages
    OB
    Samplefunc
    KSMP
    EffectAddfunc
    EFCT
    SampDat
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
function SIMMETH = SimMeth_Basic_v3b()    
end

%==================================================================
% InitViaCompass
%==================================================================  
function SIMMETH =  InitViaCompass(SIMMETH,SIMMETHipt)    
    
    SIMMETH.SaveSimImages = SIMMETHipt.('SaveSimImages');
    SIMMETH.SimObjectfunc = SIMMETHipt.('SimObjectfunc').Func; 
    OBipt = SIMMETHipt.('SimObjectfunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('SimObjectfunc_Data'))
            OBipt.SimObjectfunc_Data = SIMMETHipt.([CallingFunction,'_Data']).SimObjectfunc_Data;
        end
    end
    func = str2func(SIMMETH.SimObjectfunc);                   
    SIMMETH.OB = func();
    SIMMETH.OB.InitViaCompass(OBipt);
    
    SIMMETH.Samplefunc = SIMMETHipt.('Samplefunc').Func; 
    KSMPipt = SIMMETHipt.('Samplefunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('Samplefunc_Data'))
            KSMPipt.Samplefunc_Data = SIMMETHipt.([CallingFunction,'_Data']).Samplefunc_Data;
        end
    end
    func = str2func(SIMMETH.Samplefunc);                   
    SIMMETH.KSMP = func();
    SIMMETH.KSMP.InitViaCompass(KSMPipt);
    
    SIMMETH.EffectAddfunc = SIMMETHipt.('EffectAddfunc').Func; 
    EFCTipt = SIMMETHipt.('EffectAddfunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('EffectAddfunc_Data'))
            EFCTipt.EffectAddfunc_Data = SIMMETHipt.([CallingFunction,'_Data']).EffectAddfunc_Data;
        end
    end
    func = str2func(SIMMETH.EffectAddfunc);                   
    SIMMETH.EFCT = func();
    SIMMETH.EFCT.InitViaCompass(EFCTipt);
end 

%==================================================================
% SetSimObject
%==================================================================  
function SetSimObject(SIMMETH,SimObj)
    func = str2func(SimObj);                   
    SIMMETH.OB = func();  
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
    % BuildSimObject
    %---------------------------------------------
    err = SIMMETH.OB.BuildSimObject(SIMMETH,STCH{1});       % Use info from first acquisition
    if err.flag
        return
    end 
    SIMMETH.name = SIMMETH.OB.name;

    %---------------------------------------------
    % Effect Add
    %---------------------------------------------
    err = SIMMETH.EFCT.PreAdd(SIMMETH);        
    if err.flag
        return
    end    
    
    %---------------------------------------------
    % PlotSimObject
    %---------------------------------------------
    err = SIMMETH.OB.PlotSimObject(SIMMETH);
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
    SIMMETH.Panel = [Panel0;SIMMETH.OB.Panel;SIMMETH.EFCT.Panel]; 
    SIMMETH.PanelOutput = cell2struct(SIMMETH.Panel,{'label','value','type'},2);
    SIMMETH.ExpDisp = PanelStruct2Text(SIMMETH.PanelOutput);
    
    Status2('done','',1);
    Status2('done','',2);
    Status2('done','',3);

end


end
end






