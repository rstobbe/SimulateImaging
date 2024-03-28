%===========================================
% 
%===========================================

function [OB,err] = SimResPhanSquares_v1b_Func(OB,INPUT)

Status2('busy','Create Numerical Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Input
%---------------------------------------------
IMP = INPUT.IMP;
PROJdgn = IMP.PROJdgn;
ZF = INPUT.ZF;
SS = INPUT.SS;
clear INPUT;

%---------------------------------------------
% Object Matrix as big as possible
%---------------------------------------------
M = ZF;
% OB.OuterBoxWid = 200;
% OB.CubeDes(1) = 23.0;
% OB.CubeDes(2) = 15.0;
% OB.CubeDes(3) = 10.0;
% OB.CubeDes(4) = 7.0;
% OB.CubeDes(5) = 4.5;
% OB.CubeDes(6) = 3.0;
% OB.YDist = 15;
% OB.YShift = 20;

OB.FullFov = PROJdgn.fov*SS;
OB.ZfVox = (OB.FullFov)/M;
YDistVox = round(OB.YDist/OB.ZfVox);
YShiftVox = round(OB.YShift/OB.ZfVox);
OB.CubeVox = round(OB.CubeDes/OB.ZfVox);
OB.Cube = OB.CubeVox * OB.ZfVox;

%--------------------------------------
% Outer Box
%--------------------------------------
OB.RelOuterBoxWid = OB.OuterBoxWid/OB.FullFov;
Ob = zeros(M,M,M);
Cen = M/2;
HalfWid = floor(M*OB.RelOuterBoxWid/2);
Ob(Cen-HalfWid:Cen+HalfWid,Cen-HalfWid:Cen+HalfWid,Cen-HalfWid:Cen+HalfWid) = OB.OuterSig;

%--------------------------------------
% Inner Cubes
%--------------------------------------
YBot = Cen + YShiftVox + 2.5*YDistVox + OB.CubeVox(4) + OB.CubeVox(5) + OB.CubeVox(6);  
XBot = Cen - round(4.5*OB.CubeVox(6));
ZBot = Cen - round(0.5*OB.CubeVox(6));
Ob(YBot-(1:OB.CubeVox(6)),XBot+[(1:OB.CubeVox(6)) (OB.CubeVox(6)*2+1:OB.CubeVox(6)*3) (OB.CubeVox(6)*4+1:OB.CubeVox(6)*5) (OB.CubeVox(6)*6+1:OB.CubeVox(6)*7) (OB.CubeVox(6)*8+1:OB.CubeVox(6)*9)],ZBot+(1:OB.CubeVox(6))) = 1;

YBot = Cen + YShiftVox + 1.5*YDistVox + OB.CubeVox(4) + OB.CubeVox(5);  
XBot = Cen - round(4.5*OB.CubeVox(5));
ZBot = Cen - round(0.5*OB.CubeVox(5));
Ob(YBot-(1:OB.CubeVox(5)),XBot+[(1:OB.CubeVox(5)) (OB.CubeVox(5)*2+1:OB.CubeVox(5)*3) (OB.CubeVox(5)*4+1:OB.CubeVox(5)*5) (OB.CubeVox(5)*6+1:OB.CubeVox(5)*7) (OB.CubeVox(5)*8+1:OB.CubeVox(5)*9)],ZBot+(1:OB.CubeVox(5))) = 1;

YBot = Cen + YShiftVox + 0.5*YDistVox + OB.CubeVox(4);  
XBot = Cen - round(4.5*OB.CubeVox(4));
ZBot = Cen - round(0.5*OB.CubeVox(4));
Ob(YBot-(1:OB.CubeVox(4)),XBot+[(1:OB.CubeVox(4)) (OB.CubeVox(4)*2+1:OB.CubeVox(4)*3) (OB.CubeVox(4)*4+1:OB.CubeVox(4)*5) (OB.CubeVox(4)*6+1:OB.CubeVox(4)*7) (OB.CubeVox(4)*8+1:OB.CubeVox(4)*9)],ZBot+(1:OB.CubeVox(4))) = 1;            

YBot = Cen + YShiftVox - 0.5*YDistVox;  
XBot = Cen - round(4.5*OB.CubeVox(3));
ZBot = Cen - round(0.5*OB.CubeVox(3));
Ob(YBot-(1:OB.CubeVox(3)),XBot+[(1:OB.CubeVox(3)) (OB.CubeVox(3)*2+1:OB.CubeVox(3)*3) (OB.CubeVox(3)*4+1:OB.CubeVox(3)*5) (OB.CubeVox(3)*6+1:OB.CubeVox(3)*7) (OB.CubeVox(3)*8+1:OB.CubeVox(3)*9)],ZBot+(1:OB.CubeVox(3))) = 1;  

YBot = Cen + YShiftVox - 1.5*YDistVox - OB.CubeVox(3);  
XBot = Cen - round(4.5*OB.CubeVox(2));
ZBot = Cen - round(0.5*OB.CubeVox(2));
Ob(YBot-(1:OB.CubeVox(2)),XBot+[(1:OB.CubeVox(2)) (OB.CubeVox(2)*2+1:OB.CubeVox(2)*3) (OB.CubeVox(2)*4+1:OB.CubeVox(2)*5) (OB.CubeVox(2)*6+1:OB.CubeVox(2)*7) (OB.CubeVox(2)*8+1:OB.CubeVox(2)*9)],ZBot+(1:OB.CubeVox(2))) = 1; 

YBot = Cen + YShiftVox - 2.5*YDistVox - OB.CubeVox(3) - OB.CubeVox(2);  
XBot = Cen - round(4.5*OB.CubeVox(1));
ZBot = Cen - round(0.5*OB.CubeVox(1));
Ob(YBot-(1:OB.CubeVox(1)),XBot+[(1:OB.CubeVox(1)) (OB.CubeVox(1)*2+1:OB.CubeVox(1)*3) (OB.CubeVox(1)*4+1:OB.CubeVox(1)*5) (OB.CubeVox(1)*6+1:OB.CubeVox(1)*7) (OB.CubeVox(1)*8+1:OB.CubeVox(1)*9)],ZBot+(1:OB.CubeVox(1))) = 1; 


%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = 'SimResPhanSquares';
OB.plot = 'CentreSlice';
OB.pixdim = OB.FullFov/ZF;
OB.vox = (OB.FullFov/ZF)^3;

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(4,:) = {'Cube1 (mm)',OB.Cube(1),'Output'};
Panel(5,:) = {'Cube2 (mm)',OB.Cube(2),'Output'};
Panel(6,:) = {'Cube3 (mm)',OB.Cube(3),'Output'};
Panel(7,:) = {'Cube4 (mm)',OB.Cube(4),'Output'};
Panel(8,:) = {'Cube5 (mm)',OB.Cube(5),'Output'};
Panel(9,:) = {'Cube6 (mm)',OB.Cube(6),'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

