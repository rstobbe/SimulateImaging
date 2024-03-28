%===========================================
% 
%===========================================

function [OB,err] = SimResPhan_v1a_Func(OB,INPUT)

Status2('busy','Create Numerical Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Common Variables
%---------------------------------------------
ObMatSz = OB.ObMatSz;
ObFoV = OB.ObFoV;

%---------------------------------------------
% Test
%---------------------------------------------
M = ObMatSz;
%if not(ObMatSz==M)
%    err.flag = 1;
%    err.msg = 'ObMatSz should be 64';
%    return
%end

%--------------------------------------
% Outer Bottle
%--------------------------------------
Ob = zeros(M,M,M);
CX = (M+1)/2;
CY = (M+1)/2;
CZ = (M+1)/2;
BotDiam = M*0.7;
BotLen = M*0.35;
rmax = BotDiam/2;
for x = 1:M
    for y = 1:M
        r = sqrt((x-CX)^2 + (y-CY)^2);
        if r < rmax
            Ob(y,x,(round(CZ-BotLen/2):round(CZ+BotLen/2))) = 1.0;
        end
    end
end

%--------------------------------------
% Inner Cube
%--------------------------------------
CubeWid = M*0.49;
CubeThk = M*0.15;
Ob(ceil(CX-CubeWid/2):floor(CX+CubeWid/2),ceil(CY-CubeWid/2):floor(CY+CubeWid/2),ceil(CZ-CubeThk/2):floor(CZ+CubeThk/2)) = 0;

%--------------------------------------
% Inner Tubes
%--------------------------------------
ind1 = round(0.65*M);
inds2 = [M/2-4 M/2-2 M/2 M/2+2 M/2+4];
Ob(ind1,inds2,ceil(CZ-CubeThk/2):floor(CZ+CubeThk/2)) = 1;
ind1 = round(0.6*M);
inds2 = [(M/2-6:M/2-5) (M/2-2:M/2-1) (M/2+2:M/2+3) (M/2+6:M/2+7)];
Ob((ind1:ind1+1),inds2,ceil(CZ-CubeThk/2):floor(CZ+CubeThk/2)) = 1;
ind1 = round(0.55*M);
inds2 = [(M/2-10:M/2-8) (M/2-4:M/2-2) (M/2+2:M/2+4) (M/2+8:M/2+10)];
Ob((ind1:ind1+2),inds2,ceil(CZ-CubeThk/2):floor(CZ+CubeThk/2)) = 1;
ind1 = round(0.5*M)-3;
inds2 = [(M/2-14:M/2-11) (M/2-6:M/2-3) (M/2+2:M/2+5) (M/2+10:M/2+13)];
Ob((ind1:ind1+3),inds2,ceil(CZ-CubeThk/2):floor(CZ+CubeThk/2)) = 1;
ind1 = round(0.45*M)-8;
inds2 = [(M/2-17:M/2-13) (M/2-7:M/2-3) (M/2+3:M/2+7) (M/2+13:M/2+17)];
Ob((ind1:ind1+4),inds2,ceil(CZ-CubeThk/2):floor(CZ+CubeThk/2)) = 1;


%---------------------------------------------
% Max Displacement
%---------------------------------------------
MaxDisp = 0;
C = 32.5;
for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-C)^2 + (y-C)^2 + (z-C)^2);
            if Ob(z,x,y) == 1
                if r > MaxDisp
                    MaxDisp = r;
                end
            end
        end
    end
end
            
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.ObFoV = ObFoV;
OB.VoxelWid = ObFoV/M;
OB.VoxelVol = (ObFoV/M)^3;
OB.Tube1Wid = 1*OB.VoxelWid;
OB.Tube2Wid = 2*OB.VoxelWid;
OB.Tube3Wid = 3*OB.VoxelWid;
OB.Tube4Wid = 4*OB.VoxelWid;
OB.MaxDisp = MaxDisp*OB.VoxelWid;

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'ObMatSz',OB.ObMatSz,'Output'};
Panel(2,:) = {'ObFoV (mm)',OB.ObFoV,'Output'};
Panel(3,:) = {'ObVoxelWid (mm)',OB.VoxelWid,'Output'};
Panel(4,:) = {'ObVoxelVox (mm3)',OB.VoxelVol,'Output'};
Panel(5,:) = {'Tube1Wid (mm)',OB.Tube1Wid,'Output'};
Panel(6,:) = {'Tube2Wid (mm)',OB.Tube2Wid,'Output'};
Panel(7,:) = {'Tube3Wid (mm)',OB.Tube3Wid,'Output'};
Panel(8,:) = {'Tube4Wid (mm)',OB.Tube4Wid,'Output'};
Panel(9,:) = {'MaxDisp (mm)',OB.MaxDisp,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

