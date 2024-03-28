%===========================================
% 
%===========================================

function [OB,err] = SimTorsoRichNoArms_v1a_Func(OB,INPUT)

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
zoffset1 = 30;

xdiam1 = 250;
ydiam1 = 350;
zlen1 = 430;
xrelrad1 = ZF*(xdiam1/2/PROJdgn.fov)/SS;
yrelrad1 = ZF*(ydiam1/2/PROJdgn.fov)/SS;
zrelrad1 = ZF*(zlen1/2/PROJdgn.fov)/SS;
for x = 1:ZF
    for y = 1:ZF
        for z = 1:ZF
            if (((x-CX)/xrelrad1)^2 + ((y-CY)/yrelrad1)^2 <= 1) && abs(z-CZ+zoffset1) <= zrelrad1
                Ob(x,y,z) = 1;
            end
        end
    end
end

%--------------------------------------
% Create Lungs Hole
%--------------------------------------
xdiam2 = 170;
ydiam2 = 250;
zlen2 = 190;
zoffset2 = -20;
xrelrad2 = ZF*(xdiam2/2/PROJdgn.fov)/SS;
yrelrad2 = ZF*(ydiam2/2/PROJdgn.fov)/SS;
zrelrad2 = ZF*(zlen2/2/PROJdgn.fov)/SS;
for x = 1:ZF
    for y = 1:ZF
        for z = 1:ZF
            if (((x-CX)/xrelrad2)^2 + ((y-CY)/yrelrad2)^2 <= 1) && abs(z-CZ+zoffset2) <= zrelrad2
                Ob(x,y,z) = 0;
            end
        end
    end
end

% %--------------------------------------
% % Create Arm1
% %--------------------------------------
% xdiam3 = 100;
% ydiam3 = 100;
% %zlen3 = 430;
% zlen3 = 300;
% xrelrad3 = ZF*(xdiam3/2/PROJdgn.fov)/SS;
% yrelrad3 = ZF*(ydiam3/2/PROJdgn.fov)/SS;
% zrelrad3 = ZF*(zlen3/2/PROJdgn.fov)/SS;
% CX = (ZF+1)/2;
% CY = (ZF+1)/2 + yrelrad1 + yrelrad3;
% CZ = (ZF+1)/2;
% for x = 1:ZF
%     for y = 1:ZF
%         for z = 1:ZF
%             if (((x-CX)/xrelrad3)^2 + ((y-CY)/yrelrad3)^2 <= 1) && abs(z-CZ+zoffset1-50) <= zrelrad3
%                 Ob(x,y,z) = 1;
%             end
%         end
%     end
% end

% %--------------------------------------
% % Create Arm2
% %--------------------------------------
% xdiam4 = 100;
% ydiam4 = 100;
% %zlen4 = 430;
% zlen4 = 300;
% xrelrad4 = ZF*(xdiam4/2/PROJdgn.fov)/SS;
% yrelrad4 = ZF*(ydiam4/2/PROJdgn.fov)/SS;
% zrelrad4 = ZF*(zlen4/2/PROJdgn.fov)/SS;
% CX = (ZF+1)/2;
% CY = (ZF+1)/2 - yrelrad1 - yrelrad4;
% CZ = (ZF+1)/2;
% for x = 1:ZF
%     for y = 1:ZF
%         for z = 1:ZF
%             if (((x-CX)/xrelrad4)^2 + ((y-CY)/yrelrad4)^2 <= 1) && abs(z-CZ+zoffset1-50) <= zrelrad4
%                 Ob(x,y,z) = 1;
%             end
%         end
%     end
% end

%--------------------------------------
% Create Neck
%--------------------------------------
xdiam5 = 100;
ydiam5 = 100;
zlen5 = 80;
xoffset = -30;
xrelrad5 = ZF*(xdiam5/2/PROJdgn.fov)/SS;
yrelrad5 = ZF*(ydiam5/2/PROJdgn.fov)/SS;
zrelrad5 = ZF*(zlen5/2/PROJdgn.fov)/SS;
CX = (ZF+1)/2 + xoffset;
CY = (ZF+1)/2; 
CZ = (ZF+1)/2 + zrelrad1 + zrelrad5 - zoffset1;
for x = 1:ZF
    for y = 1:ZF
        for z = 1:ZF
            if (((x-CX)/xrelrad5)^2 + ((y-CY)/yrelrad5)^2 <= 1) && abs(z-CZ) <= zrelrad5
                Ob(x,y,z) = 1;
            end
        end
    end
end

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = ZF;
OB.name = 'SimTorsoRichNoArms';

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

