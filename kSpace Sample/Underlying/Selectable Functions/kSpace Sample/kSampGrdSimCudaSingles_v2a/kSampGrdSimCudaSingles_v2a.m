%==================================================================
% (v2a)
%   
%==================================================================

classdef kSampGrdSimCudaSingles_v2a < handle

properties (SetAccess = private)                   
    Method = 'kSampGrdSimCudaSingles_v2a'
    IF
    KRN
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [KSMP,err] = kSampGrdSimCudaSingles_v2a(KSMPipt)    
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

    %---------------------------------------------
    % ZeroFill / Reverse Filter Object
    %---------------------------------------------
    zfOb = zeros(ZF,ZF,ZF);
    sz = size(SIMMETH.OB.SimOb);
    ObMatSz = sz(1);
    Imbot = (ZF-ObMatSz)/2 + 1;
    Imtop = (ZF+ObMatSz)/2;
    zfOb(Imbot:Imtop,Imbot:Imtop,Imbot:Imtop) = SIMMETH.OB.SimOb;
    zfOb = zfOb./KSMP.IF.V;
    ftOb = fftshift(fftn(ifftshift(zfOb)));

    %---------------------------------------------
    % Sample
    %---------------------------------------------
    Status2('busy','Reverse Gridding',2);
    StatLev = 3;
    [SampDat,err] = mG2SCUDASingleC_v5c(Kx,Ky,Kz,KERN,ftOb,CONV,StatLev,CUDA);
    if err.flag
        return
    end

    %---------------------------------------------
    % Scale
    %---------------------------------------------
    SampDat = SampDat/(KSMP.KRN.convscaleval*(SubSamp^3));    

    SampDat = DatArr2Mat(SampDat,STCH.NumTraj,STCH.NumCol);
    SampDat = permute(SampDat,[2 1]);
end

end
end




