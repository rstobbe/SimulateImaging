%=========================================================
% 
%=========================================================

function [SIGDEC,err] = SigDecFile_v1a_Func(SIGDEC,INPUT)

Status2('busy','Add Signal Decay from File',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
SampDat = INPUT.SampDat;
samp = INPUT.samp;
PROJimp = INPUT.PROJimp;
Data = SIGDEC.Data;
TE = SIGDEC.TE;
clear INPUT;

%---------------------------------------------
% Add Exponential Decay
%---------------------------------------------
samp = samp + TE;
T2decay = interp1(Data.t,Data.sig,samp);
[Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
T2decaymat = repmat(T2decay,[PROJimp.nproj 1]);
SampDat = DatMat2Arr(Datmat.*T2decaymat,PROJimp.nproj,PROJimp.npro);

%--
% - Orientation Test
%SampDat = SampDat + 10000*randn(size(SampDat));
%--

%---------------------------------------------
% Return
%---------------------------------------------
SIGDEC.SampDat = SampDat;

Status2('done','',3);