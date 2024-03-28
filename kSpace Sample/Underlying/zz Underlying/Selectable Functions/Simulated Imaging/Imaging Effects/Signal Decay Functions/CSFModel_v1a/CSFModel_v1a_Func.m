%=========================================================
% 
%=========================================================

function [SIGDEC,err] = CSFModel_v1a_Func(SIGDEC,INPUT)

Status2('busy','CSF signal decay model',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
SampDat = INPUT.SampDat;
samp = INPUT.samp;
PROJimp = INPUT.PROJimp;
SysPostRfDel = SIGDEC.SysPostRfDel;
clear INPUT;

%---------------------------------------------
% CSF Model
%---------------------------------------------
T2 = 40;

%---------------------------------------------
% Add Decay
%---------------------------------------------
samp = samp + SysPostRfDel;
T2decay = exp(-samp/T2);
[Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
T2decaymat = repmat(T2decay,[PROJimp.nproj 1]);
SampDat = DatMat2Arr(Datmat.*T2decaymat,PROJimp.nproj,PROJimp.npro);

%---------------------------------------------
% Return
%---------------------------------------------
SIGDEC.SampDat = SampDat;

%---------------------------------------------
% Panel
%---------------------------------------------
Panel(1,:) = {'','','Output'};
Panel(2,:) = {'Method',SIGDEC.method,'Output'};
Panel(3,:) = {'T2 (ms)',40,'Output'};
Panel(4,:) = {'SysPostRfDel (us)',0,'Output'};
Panel(5,:) = {'TotalPostRfDel (us)',samp(1),'Output'};
PanelOutput = cell2struct(Panel,{'label','value','type'},2);   

SIGDEC.Panel = Panel;
SIGDEC.PanelOutput = PanelOutput;

Status2('done','',3);