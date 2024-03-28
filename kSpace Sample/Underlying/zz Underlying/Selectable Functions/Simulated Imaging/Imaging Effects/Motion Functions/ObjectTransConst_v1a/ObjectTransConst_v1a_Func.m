%=========================================================
% 
%=========================================================

function [TRANS,err] = ObjectTransConst_v1a_Func(TRANS,INPUT)

Status2('busy','Translate Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
IMP = INPUT.IMP;
Kmat = IMP.Kmat;
SampDat = INPUT.SampDat;
PROJimp = IMP.PROJimp;
PROJdgn = IMP.impPROJdgn;
transx = TRANS.transx;
transy = TRANS.transy;
transz = TRANS.transz;
mottype = TRANS.mottype;
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
switch mottype
    case 'FullShift'   
        phslp(:,1) = (transy/vox)*pi*ones(nproj,1);
        phslp(:,2) = (transx/vox)*pi*ones(nproj,1);
        phslp(:,3) = (transz/vox)*pi*ones(nproj,1);
end

%---------------------------------------------
% Translate 
%---------------------------------------------
Kmat = Kmat/kmax;
DatMat = DatArr2Mat(SampDat,nproj,npro);
figure(101); hold on; 
for n = 1:nproj
    DatMat(n,:) = DatMat(n,:).*exp(-1i*phslp(n,1)*ones(1,npro).*squeeze(Kmat(n,:,1)));  
    plot(Kmat(n,:,1),angle(exp(-1i*phslp(n,1)*ones(1,npro).*squeeze(Kmat(n,:,1)))),'b');
    DatMat(n,:) = DatMat(n,:).*exp(-1i*phslp(n,2)*ones(1,npro).*squeeze(Kmat(n,:,2)));  
    plot(Kmat(n,:,2),angle(exp(-1i*phslp(n,2)*ones(1,npro).*squeeze(Kmat(n,:,2)))),'r');
    DatMat(n,:) = DatMat(n,:).*exp(-1i*phslp(n,3)*ones(1,npro).*squeeze(Kmat(n,:,3)));  
    plot(Kmat(n,:,3),angle(exp(-1i*phslp(n,3)*ones(1,npro).*squeeze(Kmat(n,:,3)))),'g');
end
SampDat = DatMat2Arr(DatMat,nproj,npro);

%---------------------------------------------
% Return
%---------------------------------------------
TRANS.SampDat = SampDat;
TRANS.translations = translations;

Status2('done','',2);
Status2('done','',3);