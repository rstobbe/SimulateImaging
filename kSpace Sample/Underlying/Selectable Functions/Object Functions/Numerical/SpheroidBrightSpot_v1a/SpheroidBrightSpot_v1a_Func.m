%===========================================
% 
%===========================================

function [OB,err] = SpheroidBrightSpot_v1a_Func(OB,INPUT)

Status2('busy','Create Spheroid Object',2);
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
% Sphere Relative Diameter
%---------------------------------------------
OB.RelDiam = (OB.SphereDiam/PROJdgn.fov)/SS;

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;

%--------------------------------------
% Create Head
%--------------------------------------
Ob = zeros(M,M,M);
CX = (M+1)/2;
CY = (M+1)/2;
CZ = (M+1)/2;
BaseRad = (M/2)*OB.RelDiam;
Elip = OB.Elip;
parfor x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r == 0
                rmax = BaseRad;
            else
                phi = acos((z-CZ)/r);
                rmax = sqrt(((Elip*BaseRad)^2)/(Elip^2*(sin(phi))^2 + (cos(phi))^2));
            end
            if r <= rmax
                Ob(x,y,z) = 0.33;
            end
        end
    end
end

%---------------------------------------------
% Bright Spot
%---------------------------------------------
Ob(round(CX)-6:round(CX)+6,round(CY)-6:round(CY)+6,round(CZ+BaseRad)-12:round(CZ+BaseRad)) = 1;
Ob(round(CX)-6:round(CX)+6,round(CY+BaseRad)-12:round(CY+BaseRad),round(CZ)-6:round(CZ)+6) = 1;
Ob(round(CX+BaseRad)-12:round(CX+BaseRad),round(CY)-6:round(CY)+6,round(CZ)-6:round(CZ)+6) = 1;

%---------------------------------------------
% Orient
%---------------------------------------------
if strcmp(OB.Orient,'Y')
    Ob = permute(Ob,[3 2 1]);
elseif strcmp(OB.Orient,'X')
    Ob = permute(Ob,[1 3 2]);
end

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['Spheriod',num2str(OB.SphereDiam),'E',num2str(OB.Elip*100),num2str(OB.Orient)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'BaseDiam (mm)',OB.SphereDiam,'Output'};
Panel(4,:) = {'Elip',OB.Elip,'Output'};
Panel(5,:) = {'ElipDir',OB.Orient,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

