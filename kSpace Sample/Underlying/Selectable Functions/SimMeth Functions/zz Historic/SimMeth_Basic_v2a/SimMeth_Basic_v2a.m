%==================================================================
% (v2a)
%   
%==================================================================

classdef SimMeth_Basic_v2a < handle

properties (SetAccess = private)                   
    Method = ' SimMeth_Basic_v2a'
    Objectfunc
    OB
    Samplefunc
    KSMP
    EffectAddfunc
    EFCT
    SampDat
    ZF
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
function [SIMMETH,err] =  SimMeth_Basic_v2a(SIMMETHipt)    
    err.flag = 0;

    SIMMETH.Objectfunc = SIMMETHipt.('Objectfunc').Func; 
    OBipt = SIMMETHipt.('Objectfunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('Objectfunc_Data'))
            OBipt.Objectfunc_Data = SIMMETHipt.([CallingFunction,'_Data']).Objectfunc_Data;
        end
    end
    func = str2func(SIMMETH.Objectfunc);                   
    SIMMETH.OB = func(OBipt);
    
    SIMMETH.Samplefunc = SIMMETHipt.('Samplefunc').Func; 
    KSMPipt = SIMMETHipt.('Samplefunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('Samplefunc_Data'))
            KSMPipt.Samplefunc_Data = SIMMETHipt.([CallingFunction,'_Data']).Samplefunc_Data;
        end
    end
    func = str2func(SIMMETH.Samplefunc);                   
    SIMMETH.KSMP = func(KSMPipt);
    
    SIMMETH.EffectAddfunc = SIMMETHipt.('EffectAddfunc').Func; 
    EFCTipt = SIMMETHipt.('EffectAddfunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('EffectAddfunc_Data'))
            EFCTipt.EffectAddfunc_Data = SIMMETHipt.([CallingFunction,'_Data']).EffectAddfunc_Data;
        end
    end
    func = str2func(SIMMETH.EffectAddfunc);                   
    SIMMETH.EFCT = func(EFCTipt);    
end 

%==================================================================
% Write
%================================================================== 
function err = Simulate(SIMMETH,WRT)
  
    %---------------------------------------------
    % BuildSimObject
    %---------------------------------------------
    err = SIMMETH.OB.BuildSimObject(SIMMETH,WRT);
    if err.flag
        return
    end 
    SIMMETH.name = SIMMETH.OB.name;
    
    %---------------------------------------------
    % PlotSimObject
    %---------------------------------------------
    err = SIMMETH.OB.PlotSimObject;
    if err.flag
        return
    end       

    %---------------------------------------------
    % kSpaceSample
    %---------------------------------------------
    STCH = WRT.STCH{1};
    [SampDat0,err] = SIMMETH.KSMP.kSpaceSample(SIMMETH,STCH);
    SIMMETH.ZF = SIMMETH.KSMP.IF.ZF;
    if err.flag
        return
    end

    %---------------------------------------------
    % Effect Add
    %---------------------------------------------

    %---------------------------------------------
    % Convert to Interleaved Single
    %---------------------------------------------    
    sz = size(SampDat0);
    SIMMETH.SampDat = zeros(sz(1)*2,sz(2),'single');
    SIMMETH.SampDat(1:2:end-1,:) = single(real(SampDat0));
    SIMMETH.SampDat(2:2:end,:) = single(imag(SampDat0));
    
    %---------------------------------------------
    % Panel
    %---------------------------------------------
    Panel0(1,:) = {'','','Output'};
    Panel0(2,:) = {'WrtFile',STCH.name,'Output'};
    Panel0(3,:) = {'KernFile',SIMMETH.KSMP.KRN.name,'Output'};
    Panel0(4,:) = {'InvFiltFile',SIMMETH.KSMP.IF.name,'Output'};
    SIMMETH.Panel = [Panel0]; 
    SIMMETH.PanelOutput = cell2struct(SIMMETH.Panel,{'label','value','type'},2);
    SIMMETH.ExpDisp = PanelStruct2Text(SIMMETH.PanelOutput);

    SIMMETH.OB = [];
    SIMMETH.KSMP = [];
    SIMMETH.EFCT = [];
    
    Status2('done','',1);
    Status2('done','',2);
    Status2('done','',3);

end


end
end






