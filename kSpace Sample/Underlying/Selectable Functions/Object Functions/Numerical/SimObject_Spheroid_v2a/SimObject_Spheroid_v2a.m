%==================================================================
% (v2a)
%   
%==================================================================

classdef SimObject_Spheroid_v2a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_Spheroid_v2a'
    BaseSphereDiam
    xStretch
    yStretch
    zStretch
    RelDiam
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
function [SIMOB,err] = SimObject_Spheroid_v2a(SIMOBipt)    
    err.flag = 0;
    SIMOB.BaseSphereDiam = str2double(SIMOBipt.('BaseSphereDiam'));
    SIMOB.xStretch = str2double(SIMOBipt.('xStretch'));
    SIMOB.yStretch = str2double(SIMOBipt.('yStretch'));
    SIMOB.zStretch = str2double(SIMOBipt.('zStretch'));
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
    % Sphere Relative Diameter
    %---------------------------------------------
    SIMOB.RelDiam = (SIMOB.BaseSphereDiam/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS;

    %---------------------------------------------
    % Test
    %---------------------------------------------
    M = SIMMETH.KSMP.IF.ZF;

    %--------------------------------------
    % Create Head
    %--------------------------------------
    SIMOB.SimOb = zeros(M,M,M);
    rmax = (M/2)*SIMOB.RelDiam;
    CX = (M+1)/2;
    CY = (M+1)/2;
    CZ = (M+1)/2;
    for x = 1:M
        for y = 1:M
            for z = 1:M
                %r = sqrt((x/SIMOB.xStretch-CX)^2 + (y/SIMOB.yStretch-CY)^2 + (z/SIMOB.zStretch-CZ)^2);
                r = sqrt(((x-CX)/SIMOB.xStretch)^2 + ((y-CY)/SIMOB.yStretch)^2 + ((z-CZ)/SIMOB.zStretch)^2);
                if r <= rmax
                    %SIMOB.SimOb(z,x,y) = 1;
                    SIMOB.SimOb(y,x,z) = 1;
                end
            end
        end
    end

    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = ['Spheroid',num2str(SIMOB.BaseSphereDiam)];

    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIMOB.Panel(1,:) = {'',[],'Output'};
    SIMOB.Panel(2,:) = {'ObFunc',SIMOB.Method,'Output'};
    SIMOB.Panel(3,:) = {'BaseSphereDiam (mm)',SIMOB.BaseSphereDiam,'Output'};
    
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











