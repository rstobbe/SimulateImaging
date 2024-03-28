%=========================================================
% 
%=========================================================

function [SATREC,err] = SatRecoverMonoExp_v1a_Func(SATREC,INPUT)

Status2('busy','Add Saturation Recovery (Mono-Exponential)',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
SampDat = INPUT.SampDat;
PROJimp = INPUT.PROJimp;
T1 = SATREC.T1;
TR = SATREC.TR;
Start = SATREC.Start;
clear INPUT;

%---------------------------------------------
% Add Sat Recover
%---------------------------------------------
T1recover = 1 - exp(-(Start+(1:PROJimp.nproj)*TR)/T1);
[Datmat] = DatArr2Mat(SampDat,PROJimp.nproj,PROJimp.npro);
T1recovermat = repmat(T1recover.',[1 PROJimp.npro]);
SampDat = DatMat2Arr(Datmat.*T1recovermat,PROJimp.nproj,PROJimp.npro);

figure(1234968127);
plot(T1recover);
% figure(1234968128);
% plot(T1recovermat(3000,:));

%---------------------------------------------
% Panel Output
%---------------------------------------------
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'SatRec Method',SATREC.method,'Output'};
Panel(3,:) = {'T1 (ms)',SATREC.T1,'Output'};
Panel(4,:) = {'TR (ms)',SATREC.TR,'Output'};
Panel(5,:) = {'Start (ms)',SATREC.Start,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
SATREC.Panel = Panel;
SATREC.PanelOutput = PanelOutput;

%---------------------------------------------
% Return
%---------------------------------------------
SATREC.SampDat = SampDat;

Status2('done','',3);