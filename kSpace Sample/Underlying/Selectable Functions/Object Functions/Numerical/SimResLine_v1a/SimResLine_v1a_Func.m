%===========================================
% 
%===========================================

function [OB,err] = SimResLine_v1a_Func(OB,INPUT)

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
                Ob(y,x,z) = 0.5;
            end
        end
    end
end

%--------------------------------------
% Line
%--------------------------------------
OB.PixWidth = (PROJdgn.fov*SS)/M;
OB.LinePixels = round(OB.LineWidth0/OB.PixWidth);
OB.LineWidth = OB.PixWidth*OB.LinePixels;

Ob((M/2-50:M/2+50),M/2+30+(1:OB.LinePixels),M/2+(30:40)) = 1;
Ob((M/2-50:M/2+50),M/2+50,M/2+(30:40)) = 1;

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['SimResLine',num2str(OB.LineWidth)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'PixWidth (mm)',OB.PixWidth,'Output'};
Panel(4,:) = {'LinePixels',OB.LinePixels,'Output'};
Panel(5,:) = {'LineWidth (mm)',OB.LineWidth,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

