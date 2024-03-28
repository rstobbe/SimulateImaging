%===========================================
% 
%===========================================

function [OB,err] = SimTorsoNoArms_v1a_Func(OB,INPUT)

Status2('busy','Create Torso Object',2);
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

%--------------------------------------
% Create Torso
%--------------------------------------
Ob = zeros(ZF,ZF,ZF);
CX = (ZF+1)/2;
CY = (ZF+1)/2;
CZ = (ZF+1)/2;

xdiam1 = 300;
ydiam1 = 400;
zlen1 = PROJdgn.fov;
xrelrad1 = ZF*(xdiam1/2/PROJdgn.fov)/SS;
yrelrad1 = ZF*(ydiam1/2/PROJdgn.fov)/SS;
zrelrad1 = ZF*(zlen1/2/PROJdgn.fov)/SS;
parfor x = 1:ZF
    for y = 1:ZF
        for z = 1:ZF
            if (((x-CX)/xrelrad1)^2 + ((y-CY)/yrelrad1)^2 <= 1) && abs(z-CZ) <= zrelrad1
                Ob(x,y,z) = 1;
            end
        end
    end
end

%--------------------------------------
% Create Lungs Hole
%--------------------------------------
xdiam2 = 200;
ydiam2 = 300;
zlen2 = 250;
xrelrad2 = ZF*(xdiam2/2/PROJdgn.fov)/SS;
yrelrad2 = ZF*(ydiam2/2/PROJdgn.fov)/SS;
zrelrad2 = ZF*(zlen2/2/PROJdgn.fov)/SS;
parfor x = 1:ZF
    for y = 1:ZF
        for z = 1:ZF
            if (((x-CX)/xrelrad2)^2 + ((y-CY)/yrelrad2)^2 <= 1) && abs(z-CZ) <= zrelrad2
                Ob(x,y,z) = 0;
            end
        end
    end
end

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = ZF;
OB.name = 'SimTorsoNoArms';

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

