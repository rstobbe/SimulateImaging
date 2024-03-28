%===========================================
% 
%===========================================

function [OB,err] = Box_v1d_Func(OB,INPUT)

Status2('busy','Create Box Object',2);
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
OB.XRelDim = (OB.XDim/PROJdgn.fov)/SS;
OB.YRelDim = (OB.YDim/PROJdgn.fov)/SS;
OB.ZRelDim = (OB.ZDim/PROJdgn.fov)/SS;

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;

%--------------------------------------
% Create Cube
%--------------------------------------
Ob = zeros(M,M,M);
xdim = M*OB.XRelDim;
ydim = M*OB.YRelDim;
zdim = M*OB.ZRelDim;
cen = round((M+1)/2);
xbot = round(cen-xdim/2);
xtop = xbot+round(xdim)-1;
ybot = round(cen-ydim/2);
ytop = ybot+round(ydim)-1;
zbot = round(cen-zdim/2);
ztop = zbot+round(zdim)-1;

Ob(ybot:ytop,xbot:xtop,zbot:ztop) = 1;

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = ['Box','X',num2str(OB.XDim),'Y',num2str(OB.YDim),'Z',num2str(OB.ZDim)];

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'XDim (mm)',OB.XDim,'Output'};
Panel(4,:) = {'YDim (mm)',OB.YDim,'Output'};
Panel(5,:) = {'ZDim (mm)',OB.ZDim,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

