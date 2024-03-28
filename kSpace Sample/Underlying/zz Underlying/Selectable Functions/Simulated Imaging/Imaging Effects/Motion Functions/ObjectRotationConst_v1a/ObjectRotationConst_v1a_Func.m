%=========================================================
% 
%=========================================================

function [ROT,err] = ObjectRotationConst_v1a_Func(ROT,INPUT)

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
npro = PROJimp.npro;
mottype = ROT.mottype;

%---------------------------------------------
% Rotate k-Space
%---------------------------------------------
switch mottype
    case 'ShiftHalf'   
        rotKmat = zeros(size(Kmat));
        rotKmat(1:nproj/2,:,:) = Kmat(1:nproj/2,:,:);
        Kmat = Kmat(nproj/2+1:nproj,:,:);
        KmatArr = KMat2Arr(Kmat,nproj/2,npro);
        KmatArr = permute(KmatArr,[2 1]);
        KmatArr = Rotate3DPoints_v1a(KmatArr,ROT.rotx,ROT.roty,ROT.rotz);
        KmatArr = permute(KmatArr,[2 1]);
        rotKmat(nproj/2+1:nproj,:,:) = KArr2Mat(KmatArr,nproj/2,npro);
        rot0 = zeros(nproj,3);
        rot0(nproj/2+1:nproj,1) = ROT.rotx*ones(nproj/2,1);
        rot0(nproj/2+1:nproj,2) = ROT.roty*ones(nproj/2,1);
        rot0(nproj/2+1:nproj,3) = ROT.rotz*ones(nproj/2,1);        
    case 'FullShift'   
        KmatArr = KMat2Arr(Kmat,nproj,npro);
        KmatArr = permute(KmatArr,[2 1]);
        KmatArr = Rotate3DPoints_v1a(KmatArr,ROT.rotx,ROT.roty,ROT.rotz);
        KmatArr = permute(KmatArr,[2 1]);
        rotKmat = KArr2Mat(KmatArr,nproj,npro);
        rot0(:,1) = ROT.rotx*ones(nproj,1);
        rot0(:,2) = ROT.roty*ones(nproj,1);
        rot0(:,3) = ROT.rotz*ones(nproj,1);    
end  


%---------------------------------------------
% Return
%---------------------------------------------
ROT.Kmat = rotKmat;
ROT.rot0 = rot0;

Status2('done','',2);
Status2('done','',3);