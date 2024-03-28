%=========================================================
% 
%=========================================================

function [SIGDEC,err] = BiExpAddTE_v1b_Func(SIGDEC,INPUT)

Status2('busy','Add Bi-Exponential decay',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
SampDat = INPUT.SampDat;
samp = INPUT.samp;
PROJimp = INPUT.PROJimp;
T2f = SIGDEC.T2f;
T2s = SIGDEC.T2s;
TE = SIGDEC.TE;
clear INPUT;

%---------------------------------------------
% Add Exponential Decay
%---------------------------------------------
samp = samp + TE;
T2decay = 0.6*exp(-samp/T2f) + 0.4*exp(-samp/T2s);
if strcmp(SIGDEC.NormToOne,'Yes')
    T2decay = T2decay/T2decay(1);
end
[Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
T2decaymat = repmat(T2decay,[PROJimp.nproj 1]);
SampDat = DatMat2Arr(Datmat.*T2decaymat,PROJimp.nproj,PROJimp.npro);

%--
% - Orientation Test
%SampDat = SampDat + 10000*randn(size(SampDat));
%--

%---------------------------------------------
% Panel Output
%---------------------------------------------
Panel(1,:) = {'Signal Decay Method',SIGDEC.method,'Output'};
Panel(2,:) = {'T2f',T2f,'Output'};
Panel(3,:) = {'T2s',T2s,'Output'};
Panel(4,:) = {'TE',TE,'Output'};
SIGDEC.Panel = Panel;
PanelOutput = cell2struct(Panel,{'label','value','type'},2);
SIGDEC.PanelOutput = PanelOutput;

%---------------------------------------------
% Return
%---------------------------------------------
SIGDEC.SampDat = SampDat;

Status2('done','',3);