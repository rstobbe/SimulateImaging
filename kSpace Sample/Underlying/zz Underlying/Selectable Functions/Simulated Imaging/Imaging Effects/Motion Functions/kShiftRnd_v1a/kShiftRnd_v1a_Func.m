%=========================================================
% 
%=========================================================

function [KSHFT,err] = kShiftRnd_v1a_Func(KSHFT,INPUT)

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
shiftstdev = KSHFT.shiftstdev;
clear INPUT;

%---------------------------------------------
% Common Variables
%---------------------------------------------
nproj = PROJimp.nproj;
npro = PROJimp.npro;

%---------------------------------------------
% Random Shift values
%---------------------------------------------
shiftstdev = shiftstdev/sqrt(3);
kshfts = shiftstdev*randn(nproj,3);

%---------------------------------------------
% Shift k-Space
%---------------------------------------------
for n = 1:nproj
    for m = 1:3
        Kmat(n,:,m) = Kmat(n,:,m) + kshfts(n,m)*ones(1,npro);
    end
end

%---------------------------------------------
% Return
%---------------------------------------------
KSHFT.Kmat = Kmat;
KSHFT.kshfts = kshfts;

Status2('done','',2);
Status2('done','',3);