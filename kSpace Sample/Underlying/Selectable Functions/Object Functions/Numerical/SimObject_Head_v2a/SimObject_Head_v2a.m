%==================================================================
% (v2a)
%   
%==================================================================

classdef SimObject_Head_v2a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_Head_v2a'
    SphereDiam
    RelHeadWid
    RelIoLen
    RelHeadLoc
    ObMatSz
    SimOb
    PixWidth
    name
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIMOB,err] = SimObject_Head_v2a(SIMOBipt)    
    err.flag = 0;
end

%==================================================================
% BuildSimObject
%==================================================================  
function err = BuildSimObject(SIMOB,SIMMETH,WRT)
    err.flag = 0;
    
    Status2('busy','Create Spherical Object',2);
    Status2('done','',3);

    %---------------------------------------------
    % PixWidth
    %---------------------------------------------
    SIMOB.PixWidth = (WRT.STCH{1}.Fov*SIMMETH.KSMP.IF.SS)/SIMMETH.KSMP.IF.ZF;
    
    %---------------------------------------------
    % Head Params
    %---------------------------------------------
    HeadElip = 1.22;
    HeadWid = 180;
    SIMOB.RelHeadWid = (HeadWid/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS;
    IoLen = 180;
    SIMOB.RelIoLen = (IoLen/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS;
    HeadLoc = 10;
    SIMOB.RelHeadLoc = (HeadLoc/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS; 
    
    %---------------------------------------------
    % Test
    %---------------------------------------------
    M = SIMMETH.KSMP.IF.ZF;

    %--------------------------------------
    % Create Head
    %--------------------------------------
    Ob = zeros(M,M,M);
    MatHeadWid = M*SIMOB.RelHeadWid;
    MatIoBot = MatHeadWid/2 - (MatHeadWid - M*SIMOB.RelIoLen);
    CX = (M+1)/2;
    CY = (M+1)/2;
    CZ = (M+1)/2 + M*SIMOB.RelHeadLoc;
    parfor x = 1:M
        for y = 1:M
            for z = 1:M
                if y > M/2
                    r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                else
                    r = sqrt((x-CX)^2 + (z-CZ)^2);
                end
                if r == 0
                    rmax = MatHeadWid/2;
                else
                    phi = acos((z-CZ)/r);
                    rmax = sqrt(((HeadElip*MatHeadWid/2)^2)/(HeadElip^2*(sin(phi))^2 + (cos(phi))^2));
                end
                if r <= rmax && y > (CY-MatIoBot)
                    Ob(z,x,y) = 1;
                end
            end
        end
    end

    %---------------------------------------------
    % Setup
    %---------------------------------------------
    NoseWid = 20;
    NoseLoc = -100;
    NoseElip = 1.22;
    RelNoseWid = (NoseWid/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS; 
    RelNoseLoc = (NoseLoc/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS; 

    %--------------------------------------
    % Create Nose
    %--------------------------------------
    DoNose = 1;
    if DoNose == 1
        MatNoseWid = M*RelNoseWid;
        CX = (M+1)/2;
        CY = (M+1)/2;
        CZ = (M+1)/2 + M*RelNoseLoc;
        parfor x = 1:M
            for y = 1:M
                for z = 1:M
                    r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                    if r == 0
                        rmax = MatNoseWid/2;
                    else
                        phi = acos((z-CZ)/r);
                        rmax = sqrt(((NoseElip*MatNoseWid/2)^2)/(NoseElip^2*(sin(phi))^2 + (cos(phi))^2));
                    end
                    if r <= rmax
                        Ob(z,x,y) = 1;
                    end
                end
            end
        end
    end

    SIMOB.SimOb = Ob;    
    
    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = 'Head';

    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIMOB.Panel(1,:) = {'',[],'Output'};
    SIMOB.Panel(2,:) = {'ObFunc',SIMOB.Method,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end

%==================================================================
% PlotSimObject
%==================================================================  
function err = PlotSimObject(SIMOB,SIMMETH)
    Status2('busy','Plot Object',2);
    sz = size(SIMOB.SimOb);
    start = round(sz(3)*0.1);
    stop = round(sz(3)*0.9);
    INPUT.Image = SIMOB.SimOb(:,:,start:stop,1);
    INPUT.numberslices = 28;
    [MCHRS,err] = DefaultMontageChars_v1a(INPUT);
    fh = figure(100);
    MCHRS.MSTRCT.fhand = fh;
    INPUT = MCHRS;
    INPUT.Image = flip(INPUT.Image,2);
    if isprop(SIMMETH.KSMP,'B0Map')
        INPUT.Image(:,:,:,2) = SIMMETH.KSMP.B0Map(:,:,start:stop);
        INPUT.MSTRCT.colour2 = 'Yes';
        PlotMontageOverlay_v1e(INPUT);
    else
        PlotMontageImage_v1e(INPUT);
    end
end



end
end











