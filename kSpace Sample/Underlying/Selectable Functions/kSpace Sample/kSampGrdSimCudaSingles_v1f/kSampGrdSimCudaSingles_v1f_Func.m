%===========================================
%
%===========================================

function [KSMP,err] = kSampGrdSimCudaSingles_v1f_Func(KSMP,INPUT)

global COMPASSINFO
CUDA = COMPASSINFO.CUDA;

Status2('busy','Sample k-Space',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
Ob = INPUT.Ob;
IMP = INPUT.IMP;
B0Map = INPUT.B0Map;
IFprms = KSMP.IFprms;
KRNprms = KSMP.KRNprms;
clear INPUT;

%---------------------------------------------
% Get Gridding Ksz
%---------------------------------------------
Status2('busy','Setup Reverse Gridding',2);
Type = 'M2A';
[Ksz,SubSamp,Kx,Ky,Kz,KERN,CONV,err] = ConvSetupTest_v1b(IMP,KRNprms,Type);

%---------------------------------------------
% Setup / Test
%---------------------------------------------
ZF = IFprms.ZF;
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
if B0Map ~= 0
    err.flag = 1;
    err.msg = 'Off resonance sampling required for B0 analysis';
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
sz = size(Ob);
ObMatSz = sz(1);
Imbot = (ZF-ObMatSz)/2 + 1;
Imtop = (ZF+ObMatSz)/2;
zfOb(Imbot:Imtop,Imbot:Imtop,Imbot:Imtop) = Ob;
zfOb = zfOb./IFprms.V;
ftOb = fftshift(fftn(ifftshift(zfOb)));

%---------------------------------------------
% Sample
%---------------------------------------------
Status2('busy','Reverse Gridding',2);
StatLev = 3;
[Dat,err] = mG2SCUDASingleC_v5c(Kx,Ky,Kz,KERN,ftOb,CONV,StatLev,CUDA);
if err.flag
    return
end

%---------------------------------------------
% Scale
%---------------------------------------------
Dat = Dat/(KRNprms.convscaleval*(SubSamp^3));

%---------------------------------------------
% Return
%---------------------------------------------
KSMP.SampDat = Dat;
KSMP.ZF = ZF;




