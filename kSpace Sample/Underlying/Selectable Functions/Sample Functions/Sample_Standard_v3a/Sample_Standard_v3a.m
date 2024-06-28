%==================================================================
% (v3a)
%   - 
%==================================================================

classdef Sample_Standard_v3a < handle

properties (SetAccess = private)                   
    Method = 'Sample_Standard_v3a'
    BaseMatrix
    GridMatrix
    OffResMap
    OffResonance = 0
    RxChannels = 1
    RxProfs
    Delay = 0
    Image
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function KSMP = Sample_Standard_v3a()    
end

%==================================================================
% InitViaCompass
%==================================================================  
function KSMP = InitViaCompass(KSMP,KSMPipt)    
    KSMP.BaseMatrix = str2double(KSMPipt.('BaseMatrix'));    
end

%==================================================================
% SetBaseMatrix
%================================================================== 
function SetBaseMatrix(KSMP,BaseMatrix)
    KSMP.BaseMatrix = BaseMatrix;
end

%==================================================================
% SetOffResMap
%================================================================== 
function SetOffResMap(KSMP,OffResMap)
    KSMP.OffResMap = OffResMap;
    KSMP.OffResonance = 1;
end

%==================================================================
% SetDelay
%================================================================== 
function SetDelay(KSMP,Delay)
    KSMP.Delay = Delay;
end

%==================================================================
% SetRxProfs
%================================================================== 
function SetRxProfs(KSMP,RxProfs)
    KSMP.RxProfs = RxProfs;
    sz = size(RxProfs);
    if length(sz) == 3
        sz(4) = 1;
    end
    KSMP.RxChannels = sz(4);
end

%==================================================================
% SetImage
%================================================================== 
function SetImage(KSMP,Image)
    if isreal(Image)
        KSMP.Image = complex(single(Image),0);
    else
        KSMP.Image = single(Image);
    end
end

%==================================================================
% kSpaceSample
%================================================================== 
function [SampDat,err] = kSpaceSample(KSMP,AcqInfo)   
    err.flag = 0;
    for n = 1:gpuDeviceCount
        gpuDevice(n);
    end
    if KSMP.RxChannels == 1
        KSMP.RxProfs = complex(ones(KSMP.BaseMatrix,KSMP.BaseMatrix,KSMP.BaseMatrix,1,'single'),1e-12);
    end
    
    KernHolder = NufftKernelHolder();
    if KSMP.BaseMatrix > 600
        KernHolder.SetReducedSubSamp();           % for big zero-fill
    end
    KernHolder.SetBaseMatrix(KSMP.BaseMatrix);
    KernHolder.Initialize(AcqInfo,KSMP.RxChannels);    
    
    if KSMP.OffResonance
        OffResTimeArr = AcqInfo.OffResTimeArr + KSMP.Delay + AcqInfo.SampStartTime/1000;
        Sim = SampleOffResImage(); 
        Sim.SetBaseMatrix(KSMP.BaseMatrix);
        Sim.Initialize(AcqInfo,KSMP.RxChannels); 
        SampDat = Sim.Sample(KSMP.Image,KSMP.RxProfs,KSMP.OffResMap,OffResTimeArr);   
    else
        Sim = SampleOnResImage();
        Sim.Initialize(KernHolder,AcqInfo);
        Sim.LoadRxProfs(KSMP.RxProfs);
        SampDat = Sim.Sample(KSMP.Image);
    end
    if sum(SampDat(:)) == 0
        error('Sampling Error');
    end
    KSMP.GridMatrix = KernHolder.GridMatrix;
end

%==================================================================
% ClearImages
%==================================================================  
function ClearImages(KSMP)
    KSMP.Image = [];
    KSMP.RxProfs = [];
    KSMP.OffResMap = [];    
end

end
end




