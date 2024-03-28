%=========================================================
% 
%=========================================================

function [SIGDEC,err] = GreyMatterModel_v1a_Func(SIGDEC,INPUT)

Status2('busy','Grey Matter signal decay model',3);

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
% Build Model (ICEC)
%---------------------------------------------
load('ICECGuessDecayFlip60PL180','t','A');                               % 
ind = find(t==0.18);
t = t(ind:end)-0.18;
ICEC = A(ind:end);
% figure(12341234); hold on
% plot(t,ICEC);

%---------------------------------------------
% WM Model
%---------------------------------------------
GMdecay = ICEC/100;
% figure(12341235); hold on
% plot(t,WMdecay,'k');

%---------------------------------------------
% Add Decay
%---------------------------------------------
samp = samp + SysPostRfDel;
T2decay = interp1(t,GMdecay,samp);
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
Panel(3,:) = {'Flip (degrees)',60,'Output'};
Panel(4,:) = {'RF Pulse Length (us)',180,'Output'};
Panel(5,:) = {'SysPostRfDel (us)',0,'Output'};
Panel(6,:) = {'TotalPostRfDel (us)',samp(1),'Output'};
PanelOutput = cell2struct(Panel,{'label','value','type'},2);   

SIGDEC.Panel = Panel;
SIGDEC.PanelOutput = PanelOutput;

Status2('done','',3);