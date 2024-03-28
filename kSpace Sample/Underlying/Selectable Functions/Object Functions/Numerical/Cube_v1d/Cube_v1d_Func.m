%===========================================
% 
%===========================================

function [OB,err] = Cube_v1d_Func(OB,INPUT)

Status2('busy','Create Cube Object',2);
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
OB.RelDim = (OB.CubeDim/PROJdgn.fov)/SS;

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;

%--------------------------------------
% Create Cube
%--------------------------------------
Ob = zeros(M,M,M);
dim = M*OB.RelDim;
cen = round((M+1)/2);
bot = round(cen-dim/2);
top = bot+round(dim)-1;

Ob(bot:top,bot:top,bot:top) = 1;

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['Cube',num2str(OB.CubeDim)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'CubeDim (mm)',OB.CubeDim,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

