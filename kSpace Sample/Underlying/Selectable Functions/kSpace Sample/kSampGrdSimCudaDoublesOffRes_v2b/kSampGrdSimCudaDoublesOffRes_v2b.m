%==================================================================
% (v2b)
%   - facilitate multiple receivers
%==================================================================

classdef kSampGrdSimCudaDoublesOffRes_v2b < handle

properties (SetAccess = private)                   
    Method = 'kSampGrdSimCudaDoublesOffRes_v2b'
    IF
    KRN
    B0Map
    Delay = 0
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [KSMP,err] = kSampGrdSimCudaDoublesOffRes_v2b(KSMPipt)    
    err.flag = 0;
    CallingLabel = KSMPipt.Struct.labelstr;
    PanelLabel1 = 'Kern_File';
    PanelLabel2 = 'InvFilt_File';
    LoadAll = 0;
    if not(isfield(KSMPipt,[CallingLabel,'_Data']))
        LoadAll = 1;
    end
    if LoadAll == 1 || not(isfield(KSMPipt.([CallingLabel,'_Data']),[PanelLabel1,'_Data']))
        if isfield(KSMPipt.(PanelLabel1).Struct,'selectedfile')
            file = KSMPipt.(PanelLabel1).Struct.selectedfile;
            if not(exist(file,'file'))
                err.flag = 1;
                err.msg = ['(Re) Load ',PanelLabel1];
                ErrDisp(err);
                return
            else
                Status2('busy',['Loading ',PanelLabel1],2);
                load(file);
                saveData.path = file;
                KSMPipt.([CallingLabel,'_Data']).([PanelLabel1,'_Data']) = saveData;
            end
        else
            err.flag = 1;
            err.msg = ['(Re) Load ',PanelLabel1];
            ErrDisp(err);
            return
        end
    end
    if LoadAll == 1 || not(isfield(KSMPipt.([CallingLabel,'_Data']),[PanelLabel2,'_Data']))
        if isfield(KSMPipt.(PanelLabel2).Struct,'selectedfile')
            file = KSMPipt.(PanelLabel2).Struct.selectedfile;
            if not(exist(file,'file'))
                err.flag = 1;
                err.msg = ['(Re) Load ',PanelLabel2];
                ErrDisp(err);
                return
            else
                Status2('busy',['Loading ',PanelLabel2],2);
                load(file);
                saveData.path = file;
                KSMPipt.([CallingLabel,'_Data']).([PanelLabel2,'_Data']) = saveData;
            end
        else
            err.flag = 1;
            err.msg = ['(Re) Load ',PanelLabel2];
            ErrDisp(err);
            return
        end
    end
    KSMP.IF = KSMPipt.([CallingLabel,'_Data']).('InvFilt_File_Data').IFprms;
    KSMP.KRN = KSMPipt.([CallingLabel,'_Data']).('Kern_File_Data').KRNprms;          
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
function [SampDat,err] = kSpaceSample(KSMP,SIMMETH,STCH)   
    err.flag = 0;

    global COMPASSINFO
    CUDA = COMPASSINFO.CUDA;

    Status2('busy','Sample k-Space',2);
    Status2('done','',3);

    %---------------------------------------------
    % Get Gridding Ksz
    %---------------------------------------------
    Status2('busy','Setup Reverse Gridding',2);
    Type = 'M2A';
    [Ksz,SubSamp,Kx,Ky,Kz,KERN,CONV,err] = ConvSetupTest_v2a(STCH,KSMP.KRN,Type);

    %---------------------------------------------
    % Setup / Test
    %---------------------------------------------
    ZF = KSMP.IF.ZF;
    if Ksz > ZF
        err.flag = 1;
        err.msg = ['ZF must be greater than ',num2str(Ksz)];
        return
    end
    if rem(ZF,SubSamp)
        err.flag = 1;
        err.msg = 'ZF must be a multiple of SubSamp';
        return
    end

    %---------------------------------------------
    % k-Samp Shift
    %---------------------------------------------
    shift = (ZF/2+1)-((Ksz+1)/2);
    Kx = Kx+shift;
    Ky = Ky+shift;
    Kz = Kz+shift;

    if isprop(SIMMETH.OB,'Rcvrs')
        N = SIMMETH.OB.Rcvrs;
    else
        N = 1;
    end
    SampDat = zeros(STCH.NumCol,STCH.NumTraj,N);
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




