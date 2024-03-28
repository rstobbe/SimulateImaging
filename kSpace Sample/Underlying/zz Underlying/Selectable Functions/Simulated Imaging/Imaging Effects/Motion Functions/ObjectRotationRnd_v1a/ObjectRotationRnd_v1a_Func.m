%=========================================================
% 
%=========================================================

function [ROT,err] = ObjectRotationRnd_v1a_Func(ROT,INPUT)

Status2('busy','Rotate kSpace for Sampling',2);
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
nproj = PROJimp.nproj;
rotstdev = ROT.rotstdev;

%---------------------------------------------
% Random Rotation
%---------------------------------------------
rot0 = rotstdev*randn(nproj,3);
rot0(1,:) = 0;
%rot0(rot0 > 10) = 10;
figure(400); hold on;
a = 1;
plot(a,rot0(a,1),'bo');
plot(a,rot0(a,2),'ro');
plot(a,rot0(a,3),'go');

%---------------------------------------------
% Rotate k-Space
%---------------------------------------------
rotKmat = zeros(size(Kmat));
rotKmat(1,:,:) = Kmat(1,:,:);
for a = 2:nproj
    Karr = permute(squeeze(Kmat(a,:,:)),[2 1]);
    Karr = Rotate3DPoints_v1a(Karr,rot0(a,1),rot0(a,2),rot0(a,3));
    rotKmat(a,:,:) = permute(Karr,[2 1]);
    Status2('busy',['Randomly Rotate Trajectory: ',num2str(a)],3);
    figure(400); hold on;
    plot(a,rot0(a,1),'bo');
    plot(a,rot0(a,2),'ro');
    plot(a,rot0(a,3),'go');
end

%---------------------------------------------
% Return
%---------------------------------------------
ROT.Kmat = rotKmat;
ROT.rot0 = rot0;

Status2('done','',2);
Status2('done','',3);