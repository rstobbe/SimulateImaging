%=========================================================
% 
%=========================================================

function [TRANS,err] = ObjectTransSplit_v1b_Func(TRANS,INPUT)

Status2('busy','Add Object Translation',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
if isfield(INPUT,'prepostsamp')
    prepostsamp = INPUT.prepostsamp;
else
    prepostsamp = 'post';
end
if isfield(INPUT,'KSMP')
    KSMP = INPUT.KSMP;
    SampDat = KSMP.SampDat;
end
if isfield(INPUT,'SampDat')
    SampDat = INPUT.SampDat;
end
IMP = INPUT.IMP;
clear INPUT;

%---------------------------------------------
% Do Nothing Before Sampling
%---------------------------------------------
if strcmp(prepostsamp,'pre')
    return
end

%---------------------------------------------
% Get Input
%---------------------------------------------
Kmat = IMP.Kmat;
PROJimp = IMP.PROJimp;
PROJdgn = IMP.impPROJdgn;
transx = TRANS.transx;
transy = TRANS.transy;
transz = TRANS.transz;
clear INPUT;

%---------------------------------------------
% Common Variables
%---------------------------------------------
nproj = PROJimp.nproj;
npro = PROJimp.npro;
vox = PROJdgn.vox;
kmax = PROJdgn.kmax;

%---------------------------------------------
% Phase Ramps
%---------------------------------------------
translations(:,1) = ones(nproj,1)*transy;
translations(:,2) = ones(nproj,1)*transx;
translations(:,3) = ones(nproj,1)*transz;

phslp(:,1) = (transy/vox)*pi*ones(nproj,1);
phslp(:,2) = (transx/vox)*pi*ones(nproj,1);
phslp(:,3) = (transz/vox)*pi*ones(nproj,1);

%---------------------------------------------
% Translate 
%---------------------------------------------
Kmat = Kmat/kmax;
DatMat = DatArr2Mat(SampDat,nproj,npro);
%figure(101); hold on; 
%for n = 1:nproj
%for n = 1:nproj/2
%for n = round(nproj/2):nproj
for n = 1:nproj/4
    DatMat(n,:) = DatMat(n,:).*exp(-1i*phslp(n,1)*ones(1,npro).*squeeze(Kmat(n,:,1)));  
    %plot(Kmat(n,:,1),angle(exp(-1i*phslp(n,1)*ones(1,npro).*squeeze(Kmat(n,:,1)))),'b');
    DatMat(n,:) = DatMat(n,:).*exp(-1i*phslp(n,2)*ones(1,npro).*squeeze(Kmat(n,:,2)));  
    %plot(Kmat(n,:,2),angle(exp(-1i*phslp(n,2)*ones(1,npro).*squeeze(Kmat(n,:,2)))),'r');
    DatMat(n,:) = DatMat(n,:).*exp(-1i*phslp(n,3)*ones(1,npro).*squeeze(Kmat(n,:,3)));  
    %plot(Kmat(n,:,3),angle(exp(-1i*phslp(n,3)*ones(1,npro).*squeeze(Kmat(n,:,3)))),'g');
end
SampDat = DatMat2Arr(DatMat,nproj,npro);

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'TranslationFunc',TRANS.method,'Output'};
Panel(3,:) = {'XDim (mm)',transx,'Output'};
Panel(4,:) = {'YDim (mm)',transy,'Output'};
Panel(5,:) = {'ZDim (mm)',transz,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
TRANS.PanelOutput = PanelOutput;

%---------------------------------------------
% Return
%---------------------------------------------
TRANS.SampDat = SampDat;
TRANS.translations = translations;

Status2('done','',2);
Status2('done','',3);