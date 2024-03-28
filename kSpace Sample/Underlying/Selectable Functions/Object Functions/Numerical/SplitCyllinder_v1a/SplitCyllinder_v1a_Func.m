%===========================================
% 
%===========================================

function [OB,err] = SplitCyllinder_v1a_Func(OB,INPUT)

Status2('busy','Create Cyllinder Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Input
%---------------------------------------------
IMP = INPUT.IMP;
PROJdgn = IMP.PROJdgn;

%---------------------------------------------
% Sphere Relative Diameter
%---------------------------------------------
OB.RelDiam = OB.Diam/PROJdgn.fov;
OB.RelLength = OB.Length/PROJdgn.fov;
OB.RelSplit = OB.Split/PROJdgn.fov;

%---------------------------------------------
% Test
%---------------------------------------------
M = OB.ObMatSz;

%--------------------------------------
% Create Head
%--------------------------------------
Ob = zeros(M,M,M);
rmax = (M/2)*OB.RelDiam;
C = (M+1)/2;
Cz = M/2+1;
Zarr = Cz-ceil(M*OB.RelLength/2):Cz+floor(M*OB.RelLength/2);
for x = 1:M
    for y = 1:M
        r = sqrt((x-C)^2 + (y-C)^2);
        if r <= rmax
            Ob(x,y,Zarr) = 1;
        end
    end
end

Cz = M/2+1;
Zarr = Cz-ceil(M*OB.RelSplit/2):Cz+floor(M*OB.RelSplit/2);
Ob(:,:,Zarr) = 0;

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'ObMatSz',OB.ObMatSz,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

