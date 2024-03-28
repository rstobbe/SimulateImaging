%=========================================================
% 
%=========================================================

function [T2,err] = T2starAdd_v1a_Func(T2,INPUT)

Status2('busy','Add T2star Decay',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
IMP = INPUT.IMP;
Kmat = IMP.Kmat;
PROJimp = IMP.PROJimp;
PROJdgn = IMP.impPROJdgn;
SampDat = INPUT.KSMP.SampDat;
T2star = T2.T2star;
clear INPUT;

%---------------------------------------------
% Common Variables
%---------------------------------------------
dwell = PROJimp.dwell;
sampstart = PROJimp.sampstart;
tro = PROJdgn.tro;
nproj = PROJimp.nproj;
npro = PROJimp.npro;

%---------------------------------------------
% Add T2star
%---------------------------------------------
if length(SampDat(1,:)) == 1
    SampDatMat = DatArr2Mat(SampDat,nproj,npro);
    t = meshgrid((sampstart:dwell:tro),(1:nproj));
    SigDecay = exp(-t/T2star);
    SampDatMat = SampDatMat.*SigDecay;
    SampDatNew = DatMat2Arr(SampDatMat,nproj,npro);
else
    SampDatNew = zeros(size(SampDat));
    Nrcvrs = length(SampDat(1,:));
    t = meshgrid((sampstart:dwell:tro),(1:nproj));
    SigDecay = exp(-t/T2star);    
    for n = 1:Nrcvrs
        SampDatMat = DatArr2Mat(SampDat(:,n),nproj,npro);
        SampDatMat = SampDatMat.*SigDecay;
        SampDatNew(:,n) = DatMat2Arr(SampDatMat,nproj,npro);
    end
end
SampDat = SampDatNew;

%---------------------------------------------
% Plot
%---------------------------------------------
figure(100); hold on;
plot(t(1,:),SigDecay(1,:),'k','linewidth',2);
xlabel('Readout (ms)'); ylabel('Signal Decay');
ylim([0 1]);
figure(101); hold on;
r = squeeze(sqrt(Kmat(1,:,1).^2 + Kmat(1,:,2).^2 + Kmat(1,:,3).^2));
plot(r,SigDecay(1,:),'k','linewidth',2);
xlabel('Radial Dimension (1/m)'); ylabel('Signal Decay');
ylim([0 1]);

%---------------------------------------------
% Return
%---------------------------------------------
T2.SampDat = SampDat;

Status2('done','',2);
Status2('done','',3);



