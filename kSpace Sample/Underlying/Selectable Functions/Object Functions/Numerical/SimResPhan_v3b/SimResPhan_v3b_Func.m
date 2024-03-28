%===========================================
% 
%===========================================

function [OB,err] = SimResPhan_v3b_Func(OB,INPUT)

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

%--------------------------------------
% Outer Spere
%--------------------------------------
OB.BottleRelDiam = (OB.SphereDiam/PROJdgn.fov)/SS;
Ob = zeros(M,M,M);
rmax = (M/2)*OB.BottleRelDiam;
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
OB.ResRelDiam = (OB.ResDiam/PROJdgn.fov)/SS;
rmax = (M/2)*OB.ResRelDiam;
CX = M/2;
CY = M/2;
CZ = M/2;
for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r <= rmax
%                 Ob(y-30,x+ceil(rmax*2),z) = 1;
%                 Ob(y-30,x-ceil(rmax*2),z) = 1;
                Ob(y,x+ceil(rmax*2),z) = 1;
                Ob(y,x-ceil(rmax*2),z) = 1;
            end
        end
    end
end
            
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['ResPhan',num2str(OB.ResDiam)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'SphereDiam (mm)',OB.SphereDiam,'Output'};
Panel(4,:) = {'ResDiam (mm)',OB.ResDiam,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

