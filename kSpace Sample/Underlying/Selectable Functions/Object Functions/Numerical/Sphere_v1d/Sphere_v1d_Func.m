%===========================================
% 
%===========================================

function [OB,err] = Sphere_v1d_Func(OB,INPUT)

Status2('busy','Create Spherical Object',2);
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
rmax = (M/2)*OB.RelDiam;
CX = (M+1)/2;
CY = (M+1)/2;
CZ = (M+1)/2;
for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r <= rmax
                Ob(z,x,y) = 1;
            end
        end
    end
end
            
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['Sphere',num2str(OB.SphereDiam)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'SphereDiam (mm)',OB.SphereDiam,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

