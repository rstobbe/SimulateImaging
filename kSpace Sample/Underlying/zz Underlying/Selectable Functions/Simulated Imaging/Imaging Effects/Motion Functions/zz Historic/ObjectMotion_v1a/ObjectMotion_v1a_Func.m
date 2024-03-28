%===========================================
% 
%===========================================

function [MOT,err] = ObjectMotion_v1a_Func(MOT,INPUT)

Status2('busy','Create Object Motion',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% INPUT
%---------------------------------------------
%SCRPTipt = INPUT.SCRPTipt;
OB = INPUT.OB;
Ob = OB.Ob;

%---------------------------------------------
% Common Variables
%---------------------------------------------
Theta = MOT.Theta;
Phi = MOT.Phi;
Psi = MOT.Psi;
X = MOT.X;
Y = MOT.Y;
Z = MOT.Z;

%---------------------------------------------
% Update Panel
%---------------------------------------------
% Add

%---------------------------------------------
% Rotate Object
%---------------------------------------------
if Theta ~= 0 || Phi ~= 0 || Psi ~= 0 
    Status2('bust','Rotate Object',3);
    Ob = Rotate3D_v1a(Ob,Theta,Phi,Psi);
end

%---------------------------------------------
% Shift Object
%---------------------------------------------
if X ~= 0 || Y ~= 0 || Z ~= 0 
    Status2('bust','Rotate Object',3);
    Ob = Shift3D_v1a(Ob,Y,X,Z);
end

%---------------------------------------------
% Return
%---------------------------------------------
MOT.Ob = Ob;

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
PanelOutput = struct();
%PanelOutput = cell2struct(Panel,{'label','value','type'},2);
MOT.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

