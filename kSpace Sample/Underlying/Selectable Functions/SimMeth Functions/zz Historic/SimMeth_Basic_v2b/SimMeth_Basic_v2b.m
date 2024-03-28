%==================================================================
% (v2b)
%       - update for multiple KINFO
%==================================================================

classdef SimMeth_Basic_v2b < handle

properties (SetAccess = private)                   
    Method = 'SimMeth_Basic_v2b'
    SimObjectfunc
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
function [SIMMETH,err] =  SimMeth_Basic_v2b(SIMMETHipt)    
    err.flag = 0;

    SIMMETH.SimObjectfunc = SIMMETHipt.('SimObjectfunc').Func; 
    OBipt = SIMMETHipt.('SimObjectfunc');
    CallingFunction = SIMMETHipt.Struct.labelstr;
    if isfield(SIMMETHipt,([CallingFunction,'_Data']))
        if isfield(SIMMETHipt.([CallingFunction,'_Data']),('SimObjectfunc_Data'))
            OBipt.SimObjectfunc_Data = SIMMETHipt.([CallingFunction,'_Data']).SimObjectfunc_Data;
        end
    end
    func = str2func(SIMMETH.SimObjectfunc);                   
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
% SetMultipleReceiverObjects
%==================================================================  
function SetMultipleReceiverObjects(SIMMETH,Rcvrs)
    func = str2func('SimObject_ArrayHolder_v2a');
    SIMMETH.OB = func(Rcvrs);
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

    SIMMETH.ZF = SIMMETH.KSMP.IF.ZF;    
    for n = 1:length(WRT.STCH)

        %---------------------------------------------
        % kSpaceSample
        %---------------------------------------------
        STCH = WRT.STCH{n};
        [SampDat0,err] = SIMMETH.KSMP.kSpaceSample(SIMMETH,STCH);
        if err.flag
            return
        end

        %---------------------------------------------
        % Effect Add
        %---------------------------------------------
        [SampDat0,err] = SIMMETH.EFCT.PostAdd(SIMMETH,STCH,SampDat0);
        
        %---------------------------------------------
        % Convert to Interleaved Single
        %---------------------------------------------    
        sz = size(SampDat0);
        if length(sz) == 2
            sz(3) = 1;
        end
        SIMMETH.SampDat{n} = zeros(sz(1)*2,sz(2),sz(3),'single');
        SIMMETH.SampDat{n}(1:2:end-1,:,:) = single(real(SampDat0));
        SIMMETH.SampDat{n}(2:2:end,:,:) = single(imag(SampDat0));
    end
    
    %---------------------------------------------
    % Panel
    %---------------------------------------------
    Panel0(1,:) = {'','','Output'};
    Panel0(2,:) = {'WrtFile',STCH.name,'Output'};
    Panel0(3,:) = {'KernFile',SIMMETH.KSMP.KRN.name,'Output'};
    Panel0(4,:) = {'InvFiltFile',SIMMETH.KSMP.IF.name,'Output'};
    SIMMETH.Panel = [Panel0;SIMMETH.OB.Panel;SIMMETH.EFCT.Panel]; 
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






