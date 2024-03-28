%=========================================================
% 
%=========================================================

function [KSHFT,err] = kShiftConst_v1a_Func(KSHFT,INPUT)

Status2('busy','Shift kSpace',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
IMP = INPUT.IMP;
Kmat = IMP.Kmat;
PROJimp = IMP.PROJimp;
clear INPUT;

%---------------------------------------------
% Common Variables
%---------------------------------------------
shift(1) = KSHFT.shiftX;
shift(2) = KSHFT.shiftY;
shift(3) = KSHFT.shiftZ;
nproj = PROJimp.nproj;
npro = PROJimp.npro;

%---------------------------------------------
% Shift k-Space
%---------------------------------------------
for n = 1:nproj
    for m = 1:3
        Kmat(n,:,m) = Kmat(n,:,m) + shift(m)*ones(1,npro);
    end
end

%---------------------------------------------
% Return
%---------------------------------------------
KSHFT.Kmat = Kmat;

Status2('done','',2);
Status2('done','',3);