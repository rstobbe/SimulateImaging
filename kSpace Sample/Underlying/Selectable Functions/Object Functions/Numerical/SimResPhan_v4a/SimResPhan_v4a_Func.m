%===========================================
% 
%===========================================

function [OB,err] = SimResPhan_v4a_Func(OB,INPUT)

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
OB.SphereDiam = 70;
OB.ResDiam1 = 5;
OB.ResDiam2 = 4;
OB.ResDiam3 = 3;
OB.ResDiam4 = 2;
OB.ResDiam5 = 1;
OB.YDist = 15;

%--------------------------------------
% Outer Spere
%--------------------------------------
OB.SphereRelDiam = (OB.SphereDiam/PROJdgn.fov)/SS;
Ob = zeros(M,M,M);
rmax = (M/2)*OB.SphereRelDiam;
CX = (M+1)/2;
CY = (M+1)/2;
CZ = (M+1)/2;
for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r < rmax
                Ob(y,x,z) = 0.25;
            end
        end
    end
end

%--------------------------------------
% Inner Spheres
%--------------------------------------
OB.ResRelDiam1 = (OB.ResDiam1/PROJdgn.fov)/SS;
OB.ResRelDiam2 = (OB.ResDiam2/PROJdgn.fov)/SS;
OB.ResRelDiam3 = (OB.ResDiam3/PROJdgn.fov)/SS;
OB.ResRelDiam4 = (OB.ResDiam4/PROJdgn.fov)/SS;
OB.ResRelDiam5 = (OB.ResDiam5/PROJdgn.fov)/SS;
OB.YRelDist = (OB.YDist/PROJdgn.fov)/SS;
OB.YRelDist = (OB.YDist/PROJdgn.fov)/SS;
rmax1 = (M/2)*OB.ResRelDiam1;
rmax2 = (M/2)*OB.ResRelDiam2;
rmax3 = (M/2)*OB.ResRelDiam3;
rmax4 = (M/2)*OB.ResRelDiam4;
rmax5 = (M/2)*OB.ResRelDiam5;
ydist = (M/2)*OB.YRelDist;
shift = (M/2)*(15/PROJdgn.fov)/SS;
CX = M/2;
CY = M/2;
CZ = M/2;
for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r <= rmax1
                Ob(y-ceil(2*ydist+(rmax1+rmax2)*2)+shift,x+ceil(rmax1*6),z) = 1;
                Ob(y-ceil(2*ydist+(rmax1+rmax2)*2)+shift,x+ceil(rmax1*2),z) = 1;
                Ob(y-ceil(2*ydist+(rmax1+rmax2)*2)+shift,x-ceil(rmax1*2),z) = 1;
                Ob(y-ceil(2*ydist+(rmax1+rmax2)*2)+shift,x-ceil(rmax1*6),z) = 1;                
            end
            if r <= rmax2
                Ob(y-ceil(ydist+rmax2*2)+shift,x+ceil(rmax2*6),z) = 1;
                Ob(y-ceil(ydist+rmax2*2)+shift,x+ceil(rmax2*2),z) = 1;
                Ob(y-ceil(ydist+rmax2*2)+shift,x-ceil(rmax2*2),z) = 1;
                Ob(y-ceil(ydist+rmax2*2)+shift,x-ceil(rmax2*6),z) = 1;
            end
            if r <= rmax3
                Ob(y+shift,x+ceil(rmax3*6),z) = 1;
                Ob(y+shift,x+ceil(rmax3*2),z) = 1;
                Ob(y+shift,x-ceil(rmax3*2),z) = 1;
                Ob(y+shift,x-ceil(rmax3*6),z) = 1;
            end
            if r <= rmax4
                Ob(y+ceil(ydist+rmax4*2)+shift,x+ceil(rmax4*6),z) = 1;
                Ob(y+ceil(ydist+rmax4*2)+shift,x+ceil(rmax4*2),z) = 1;
                Ob(y+ceil(ydist+rmax4*2)+shift,x-ceil(rmax4*2),z) = 1;
                Ob(y+ceil(ydist+rmax4*2)+shift,x-ceil(rmax4*6),z) = 1;
            end
            if r <= rmax5
                Ob(y+ceil(2*ydist+(rmax5+rmax4)*2)+shift,x+ceil(rmax5*6),z) = 1;
                Ob(y+ceil(2*ydist+(rmax5+rmax4)*2)+shift,x+ceil(rmax5*2),z) = 1;
                Ob(y+ceil(2*ydist+(rmax5+rmax4)*2)+shift,x-ceil(rmax5*2),z) = 1;
                Ob(y+ceil(2*ydist+(rmax5+rmax4)*2)+shift,x-ceil(rmax5*6),z) = 1;
            end
        end
    end
end
            
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = 'ResPhan54321';
OB.plot = 'CentreSlice';

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'SphereDiam (mm)',OB.SphereDiam,'Output'};
Panel(4,:) = {'ResDiam1 (mm)',OB.ResDiam1,'Output'};
Panel(5,:) = {'ResDiam2 (mm)',OB.ResDiam2,'Output'};
Panel(6,:) = {'ResDiam3 (mm)',OB.ResDiam3,'Output'};
Panel(7,:) = {'ResDiam4 (mm)',OB.ResDiam4,'Output'};
Panel(8,:) = {'ResDiam5 (mm)',OB.ResDiam5,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

