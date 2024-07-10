%==================================================================
% (v2a)
%   
%==================================================================

classdef SimObject_ExternalDefine_v2a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_ExternalDefine_v2a'
    ObMatSz
    PixWidth
    name
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function SIMOB = SimObject_ExternalDefine_v2a()    
end

%==================================================================
% InitViaCompass
%==================================================================  
function InitViaCompass(SIMOB,SIMOBipt)    
end

%==================================================================
% InitViaCompass
%==================================================================  
function SetSimObject(SIMOB,Obj)    
end

%==================================================================
% BuildSimObject
%==================================================================  
function err = BuildSimObject(SIMOB,SIMMETH,STCH)
    err.flag = 0;
    
    Status2('busy','Create Spherical Object',2);
    Status2('done','',3);

    %---------------------------------------------
    % PixWidth
    %---------------------------------------------
    SIMOB.PixWidth = STCH.Fov/SIMMETH.KSMP.BaseMatrix;
    
    %---------------------------------------------
    % Sphere Relative Diameter
    %---------------------------------------------
    SIMOB.RelDiam = SIMOB.BaseSphereDiam/STCH.Fov;

    %--------------------------------------
    % Create Head
    %--------------------------------------
    M = SIMMETH.KSMP.BaseMatrix;
    SimOb = zeros(M,M,M);
    rmax = (M/2)*SIMOB.RelDiam;
    CX = (M+1)/2;
    CY = (M+1)/2;
    CZ = (M+1)/2;
    for x = 1:M
        for y = 1:M
            for z = 1:M
                r = sqrt(((x-CX)/SIMOB.xStretch)^2 + ((y-CY)/SIMOB.yStretch)^2 + ((z-CZ)/SIMOB.zStretch)^2);
                if r <= rmax
                    SimOb(y,x,z) = rand(1);
                end
            end
        end
    end

    SIMMETH.KSMP.SetImage(SimOb);

    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = ['SpheroidFillRandRad',num2str(SIMOB.BaseSphereDiam)];

    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIMOB.Panel(1,:) = {'',[],'Output'};
    SIMOB.Panel(2,:) = {'ObFunc',SIMOB.Method,'Output'};
    SIMOB.Panel(3,:) = {'BaseSphereDiam (mm)',SIMOB.BaseSphereDiam,'Output'};
    SIMOB.Panel(4,:) = {'xStretch',SIMOB.xStretch,'Output'};
    SIMOB.Panel(5,:) = {'yStretch',SIMOB.yStretch,'Output'};
    SIMOB.Panel(6,:) = {'zStretch',SIMOB.zStretch,'Output'};    

    Status2('done','',2);
    Status2('done','',3);
end

%==================================================================
% PlotSimObject
%==================================================================  
function err = PlotSimObject(SIMOB,SIMMETH)
    Status2('busy','Plot Object',2);
    sz = size(SIMMETH.KSMP.Image);
    start = round(sz(3)*0.1);
    stop = round(sz(3)*0.9);
    INPUT.Image = SIMMETH.KSMP.Image(:,:,start:stop,1);
    INPUT.numberslices = 28;
    [MCHRS,err] = DefaultMontageChars_v1a(INPUT);
    fh = figure(100);
    MCHRS.MSTRCT.fhand = fh;
    INPUT = MCHRS;
    INPUT.Image = flip(INPUT.Image,2);
    if SIMMETH.KSMP.OffResonance
        INPUT.Image(:,:,:,2) = SIMMETH.KSMP.OffResMap(:,:,start:stop);
        INPUT.MSTRCT.colour2 = 'Yes';
        PlotMontageOverlay_v1e(INPUT);
    else
        PlotMontageImage_v1e(INPUT);
    end
end



end
end











