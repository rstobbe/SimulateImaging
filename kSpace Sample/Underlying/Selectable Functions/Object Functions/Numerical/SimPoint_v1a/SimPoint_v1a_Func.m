%===========================================
% 
%===========================================

function [OB,err] = SimPoint_v1a_Func(OB,INPUT)

Status2('busy','Create Head Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Input
%---------------------------------------------
IMP = INPUT.IMP;
ZF = INPUT.ZF;
clear INPUT;

%---------------------------------------------
% Test
%---------------------------------------------
M = ZF;

%--------------------------------------
% Create Head
%--------------------------------------
Ob = zeros(M,M,M);
Ob(M/2,M/2,M/2) = 1;
      
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = 'Point';

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

