%==================================================================
% (v2b)
%   - facilitate multiple receivers
%==================================================================

classdef kSampGrdSimCudaOffRes_v3a < handle

properties (SetAccess = private)                   
    Method = 'kSampGrdSimCudaOffRes_v3a'
    B0Map
    BaseMatrix
    Delay = 0
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [KSMP,err] = kSampGrdSimCudaOffRes_v3a(KSMPipt)    
    err.flag = 0;
    KSMP.BaseMatrix = str2double(KSMPipt.('BaseMatrix'));
end

%==================================================================
% SetB0Map
%================================================================== 
function SetB0Map(KSMP,B0Map)
    KSMP.B0Map = B0Map;
end

%==================================================================
% SetB0Map
%================================================================== 
function SetDelay(KSMP,Delay)
    KSMP.Delay = Delay;
end

%==================================================================
% kSpaceSample
%================================================================== 
function [SampDat,err] = kSpaceSample(KSMP,SIMMETH,AcqInfo)   
    err.flag = 0;

    OffResTimeArr = AcqInfo.OffResTimeArr + KSMP.Delay;

    if isprop(SIMMETH.OB,'Rcvrs')
        RxChannels = SIMMETH.OB.Rcvrs;
    else
        RxChannels = 1;
        RxProfs = complex(ones(KSMP.BaseMatrix,KSMP.BaseMatrix,KSMP.BaseMatrix,RxChannels,'single'),1e-10);
    end

    Sim = SampleOffResImage(); 
    Sim.SetBaseMatrix(KSMP.BaseMatrix);
    Sim.Initialize(AcqInfo,RxChannels); 

    if isempty(KSMP.B0Map)
        OffResMap = zeros(BaseMatrix,BaseMatrix,BaseMatrix,'single');                     % Hz
    end
    Data = Sim.Sample(Image,RxProfs,OffResMap);   
    SIMMETH.OB.SimOb

    
    
    SampDat = zeros(AcqInfo.NumCol,AcqInfo.NumTraj,N);
    for n = 1:N
        %---------------------------------------------
        % ZeroFill / Reverse Filter Object
        %---------------------------------------------
        zfOb = zeros(ZF,ZF,ZF);
        sz = size(SIMMETH.OB.SimOb);
        ObMatSz = sz(1);
        Imbot = (ZF-ObMatSz)/2 + 1;
        Imtop = (ZF+ObMatSz)/2;
        zfOb(Imbot:Imtop,Imbot:Imtop,Imbot:Imtop) = SIMMETH.OB.SimOb(:,:,:,n);
        zfOb = zfOb./KSMP.IF.V;
        zfOb = ifftshift(zfOb);

        %---------------------------------------------
        % B0Map
        %---------------------------------------------
        T = (STCH.SamplingTimeOnTrajectory + KSMP.Delay)/1000;                  % in ms

        %--- Chunk testing --- 
    %     ChunkLen = 150;
    %     ChunkNum = ceil(length(T)/ChunkLen);
    %     T2 = zeros(size(T));
    %     for n = 1:ChunkNum-1
    %         T2((n-1)*ChunkLen+1:n*ChunkLen) = T((n-1)*ChunkLen+1:n*ChunkLen) - T((n-1)*ChunkLen+1);
    %     end
    %     T2((ChunkNum-1)*ChunkLen+1:end) = T((ChunkNum-1)*ChunkLen+1:end) - T((ChunkNum-1)*ChunkLen+1);
    %     figure(3234);
    %     plot(T-T(1),T2);    
    %     T = T2;
        %---------------------

        Off = zeros(ZF,ZF,ZF);
        Off(Imbot:Imtop,Imbot:Imtop,Imbot:Imtop) = KSMP.B0Map;
        Off = ifftshift(Off);

        %---------------------------------------------
        % Sample
        %---------------------------------------------
        Status2('busy','Reverse Gridding',2);
        StatLev = 3;
        tic
        [SampDat0,err] = mSampOffResCUDADoubles_v1j(zfOb,Off,T,Kx,Ky,Kz,KERN,CONV,StatLev);
        toc
        if err.flag
            return
        end

        %---------------------------------------------
        % Scale
        %---------------------------------------------
        SampDat0 = SampDat0/(KSMP.KRN.convscaleval*(SubSamp^3));    
        SampDat0 = DatArr2Mat(SampDat0,STCH.NumTraj,STCH.NumCol);
        SampDat0 = permute(SampDat0,[2 1]);
        SampDat(:,:,n) = SampDat0;
    end
end

end
end




