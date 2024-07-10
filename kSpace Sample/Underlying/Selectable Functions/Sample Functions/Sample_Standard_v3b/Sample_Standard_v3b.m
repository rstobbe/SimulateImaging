%==================================================================
% (v3a)
%   - 
%==================================================================

classdef Sample_Standard_v3b < handle

properties (SetAccess = private)                   
    Method = 'Sample_Standard_v3b'
    BaseMatrix
    GridMatrix
    OffResMap
    Sim
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
function KSMP = Sample_Standard_v3b()    
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
% kSpaceSampleInitialize
%================================================================== 
function kSpaceSampleInitialize(KSMP,AcqInfo)   
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
        KSMP.Sim = SampleOffResImage(); 
        KSMP.Sim.SetBaseMatrix(KSMP.BaseMatrix);
        KSMP.Sim.Initialize(AcqInfo,KSMP.RxChannels);  
    else
        KSMP.Sim = SampleOnResImage();
        KSMP.Sim.Initialize(KernHolder,AcqInfo);
        KSMP.Sim.LoadRxProfs(KSMP.RxProfs);
    end
    KSMP.GridMatrix = KernHolder.GridMatrix;
end

%==================================================================
% kSpaceSample
%================================================================== 
function SampDat = kSpaceSample(KSMP)  
    if KSMP.OffResonance
        OffResTimeArr = AcqInfo.OffResTimeArr + KSMP.Delay + AcqInfo.SampStartTime/1000;
        SampDat = KSMP.Sim.Sample(KSMP.Image,KSMP.RxProfs,KSMP.OffResMap,OffResTimeArr);   
    else
        SampDat = KSMP.Sim.Sample(KSMP.Image);
    end
    if sum(SampDat(:)) == 0
        error('Sampling Error');
    end
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




