%===========================================
% 
%===========================================

function [OB,err] = Plane_v1c_Func(OB,INPUT)

Status2('busy','Create Plane Object',2);
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
rThick = (OB.thk/PROJdgn.fov)/SS;
rLen = (OB.len/PROJdgn.fov)/SS;

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;
Thk = round(rThick*M);
Len = round(rLen*M);

%--------------------------------------
% Create Head
%--------------------------------------
Ob = zeros(M,M,M);
botLen = M/2 - ceil(Len/2);
topLen = botLen + Len - 1;
botThk = M/2 - ceil(Thk/2);
topThk = botThk + Thk - 1;
%Ob(botLen:topLen,botLen:topLen,botThk:topThk) = 1;
Ob(botThk:topThk,botLen:topLen,botLen:topLen) = 1;

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.Thickness = (Thk/M)*PROJdgn.fov*SS;
OB.Length = (Len/M)*PROJdgn.fov*SS;
OB.name = ['Plane',num2str(OB.Thickness),num2str(OB.Length)];
OB.plot = 'CentreSlice';

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'Thickness (mm)',OB.Thickness,'Output'};
Panel(4,:) = {'Length (mm)',OB.Length,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

