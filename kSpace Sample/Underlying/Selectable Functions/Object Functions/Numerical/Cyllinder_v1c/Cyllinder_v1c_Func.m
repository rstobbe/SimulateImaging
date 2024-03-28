%===========================================
% 
%===========================================

function [OB,err] = Cyllinder_v1c_Func(OB,INPUT)

Status2('busy','Create Cyllinder Object',2);
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
OB.RelDiam = (OB.Diam/PROJdgn.fov)/SS;
OB.RelLength = (OB.Length/PROJdgn.fov)/SS;

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;

%--------------------------------------
% Create Head
%--------------------------------------
Ob = zeros(M,M,M);
rmax = (M/2)*OB.RelDiam;
C = (M+1)/2;
Cz = M/2+1;
Zarr = Cz-ceil(M*OB.RelLength/2):Cz+floor(M*OB.RelLength/2)-1;
for x = 1:M
    for y = 1:M
        r = sqrt((x-C)^2 + (y-C)^2);
        if r <= rmax
            Ob(x,y,Zarr) = 1;
        end
    end
end

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
OB.name = ['Cyllinder_D',num2str(OB.Diam),'_L',num2str(OB.Length),'_',OB.Orient];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'Cyllinder Diameter (mm)',OB.Diam,'Output'};
Panel(4,:) = {'Cyllinder Length (mm)',OB.Length,'Output'};
Panel(5,:) = {'Cyllinder Orientation',OB.Orient,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

