%===========================================
% 
%===========================================

function [OB,err] = SimHead_v2f_Func(OB,INPUT)

Status2('busy','Create Head Object',2);
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
% Setup
%---------------------------------------------
HeadLoc = 10;
HeadElip = 1.22;
RelHeadWid = OB.HeadWid/(PROJdgn.fov*SS);
RelHeadLoc = HeadLoc/(PROJdgn.fov*SS);
RelIoFov = OB.IoFov/(PROJdgn.fov*SS);

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;

%--------------------------------------
% Create Head
%--------------------------------------
Ob = zeros(M,M,M);
MatHeadWid = M*RelHeadWid;
MatIoBot = MatHeadWid/2 - (MatHeadWid - M*RelIoFov);
CX = (M+1)/2;
CY = (M+1)/2;
CZ = (M+1)/2 + M*RelHeadLoc;
parfor x = 1:M
    for y = 1:M
        for z = 1:M
            if y > M/2
                r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            else
                r = sqrt((x-CX)^2 + (z-CZ)^2);
            end
            if r == 0
                rmax = MatHeadWid/2;
            else
                phi = acos((z-CZ)/r);
                rmax = sqrt(((HeadElip*MatHeadWid/2)^2)/(HeadElip^2*(sin(phi))^2 + (cos(phi))^2));
            end
            if r <= rmax && y > (CY-MatIoBot)
                Ob(z,x,y) = 1;
            end
        end
    end
end

%---------------------------------------------
% Setup
%---------------------------------------------
NoseWid = 20;
NoseLoc = -100 + (180-OB.HeadWid)/2;
NoseElip = 1.22;
RelNoseWid = NoseWid/(PROJdgn.fov*SS);
RelNoseLoc = NoseLoc/(PROJdgn.fov*SS);

%--------------------------------------
% Create Nose
%--------------------------------------
DoNose = 0;
if DoNose == 1
    MatNoseWid = M*RelNoseWid;
    CX = (M+1)/2;
    CY = (M+1)/2;
    CZ = (M+1)/2 + M*RelNoseLoc;
    parfor x = 1:M
        for y = 1:M
            for z = 1:M
                r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                if r == 0
                    rmax = MatNoseWid/2;
                else
                    phi = acos((z-CZ)/r);
                    rmax = sqrt(((NoseElip*MatNoseWid/2)^2)/(NoseElip^2*(sin(phi))^2 + (cos(phi))^2));
                end
                if r <= rmax
                    Ob(z,x,y) = 1;
                end
            end
        end
    end
end
         
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['Head',num2str(OB.HeadWid),'Cut',num2str(OB.IoFov)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'HeadWid (mm)',OB.HeadWid,'Output'};
Panel(4,:) = {'HeadLength (mm)',OB.HeadWid*HeadElip,'Output'};
Panel(5,:) = {'HeadIoCut (mm)',OB.IoFov,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

