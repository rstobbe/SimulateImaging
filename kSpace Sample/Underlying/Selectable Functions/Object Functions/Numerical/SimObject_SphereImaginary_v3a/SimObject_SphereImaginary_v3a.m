%==================================================================
% (v3a)
%   
%==================================================================

classdef SimObject_SphereImaginary_v3a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_SphereImaginary_v3a'
    SphereDiam
    RelDiam
    ObMatSz
    PixWidth
    name
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIMOB,err] = SimObject_SphereImaginary_v3a(SIMOBipt)    
    err.flag = 0;
    SIMOB.SphereDiam = str2double(SIMOBipt.('SphereDiam'));
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
    SIMOB.RelDiam = SIMOB.SphereDiam/STCH.Fov;

    %--------------------------------------
    % Create Sphere
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
                r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                if r <= rmax
                    SimOb(z,x,y) = 1i;
                end
            end
        end
    end
    SIMMETH.KSMP.SetImage(SimOb);
    
    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = ['Sphere',num2str(SIMOB.SphereDiam)];

    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIMOB.Panel(1,:) = {'',[],'Output'};
    SIMOB.Panel(2,:) = {'ObFunc',SIMOB.Method,'Output'};
    SIMOB.Panel(3,:) = {'SphereDiam (mm)',SIMOB.SphereDiam,'Output'};
    
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











