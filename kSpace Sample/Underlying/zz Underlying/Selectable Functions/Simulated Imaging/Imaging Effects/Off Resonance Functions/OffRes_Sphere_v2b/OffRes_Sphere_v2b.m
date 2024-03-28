%==================================================================
% (v2b)
%   - add filter option
%==================================================================

classdef OffRes_Sphere_v2b < handle

properties (SetAccess = private)                   
    Method = 'OffRes_Sphere_v2a'
    OffRes
    SphereDiam
    Delay
    FiltVox
    FiltBeta
    XShift
    YShift
    ZShift
    Panel = cell(0)
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [B0MAP,err] = OffRes_Sphere_v2b(B0MAPipt)    
    err.flag = 0;
    B0MAP.SphereDiam = str2double(B0MAPipt.('SphereDiam'));
    B0MAP.OffRes = str2double(B0MAPipt.('OffRes'));
    B0MAP.Delay = str2double(B0MAPipt.('Delay'));
    B0MAP.FiltVox = str2double(B0MAPipt.('FiltVox'));
    B0MAP.FiltBeta = str2double(B0MAPipt.('FiltBeta'));
    B0MAP.XShift = str2double(B0MAPipt.('XShift'));
    B0MAP.YShift = str2double(B0MAPipt.('YShift'));
    B0MAP.ZShift = str2double(B0MAPipt.('ZShift'));
end

%==================================================================
% AddPreEffect
%==================================================================  
function [err] = AddPreEffect(B0MAP,SIMMETH)

    %---------------------------------------------
    % Get Input
    %---------------------------------------------
    ObMatSz = SIMMETH.OB.ObMatSz;
    PixWidth = SIMMETH.OB.PixWidth;
    clear INPUT;

    %---------------------------------------------
    % Get Input
    %---------------------------------------------
    SphereDiamMat = B0MAP.SphereDiam/PixWidth;
    B0Map = zeros([ObMatSz,ObMatSz,ObMatSz]);
    XShiftMat = B0MAP.XShift/PixWidth;
    YShiftMat = B0MAP.YShift/PixWidth;
    ZShiftMat = B0MAP.ZShift/PixWidth;    
    CX = (ObMatSz+1)/2 - XShiftMat;
    CY = (ObMatSz+1)/2 + YShiftMat;
    CZ = (ObMatSz+1)/2 - ZShiftMat;
    for x = 1:ObMatSz
        for y = 1:ObMatSz
            for z = 1:ObMatSz
                rad = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                if rad <= (SphereDiamMat/2)
                    B0Map(z,x,y) = B0MAP.OffRes;
                end
            end
        end
    end

    %---------------------------------------------
    % Low Pass Filter
    %---------------------------------------------    
    Fov = PixWidth*ObMatSz;
    [x,y,z] = size(B0Map);
    imkmaxx = 1000/(2*PixWidth);
    imkmaxy = 1000/(2*PixWidth);
    imkmaxz = 1000/(2*PixWidth);
    lpkmax = 1000/(2*B0MAP.FiltVox);
    if lpkmax > imkmaxx
        err.flag = 1;
        err.msg = 'Filter kmax > Image kmax in x-dimension';
        return
    end
    if lpkmax > imkmaxy
        err.flag = 1;
        err.msg = 'Filter kmax > Image kmax in y-dimension';
        return
    end
    if lpkmax > imkmaxz
        err.flag = 1;
        err.msg = 'Filter kmax > Image kmax in z-dimension';
        return
    end

    dimx = 2*(round((x*lpkmax/(1000*x/(2*Fov)))/2)); 
    dimy = 2*(round((y*lpkmax/(1000*y/(2*Fov)))/2)); 
    dimz = 2*(round((z*lpkmax/(1000*z/(2*Fov)))/2)); 

    %---------------------------------------------
    % Drop Resolution
    %---------------------------------------------
    Filt = Kaiser_v1b(dimx,dimy,dimz,B0MAP.FiltBeta,'unsym');
    botx = (x-dimx)/2+1;
    topx = botx+dimx-1;
    boty = (y-dimy)/2+1;
    topy = boty+dimy-1;
    botz = (z-dimz)/2+1;
    topz = botz+dimz-1;

    k = fftshift(ifftn(ifftshift(B0Map)));
    k2 = zeros(size(k));
    k2(botx:topx,boty:topy,botz:topz) = Filt.*k(botx:topx,boty:topy,botz:topz);
    B0Map = abs(fftshift(fftn(ifftshift(k2))));
    
    SIMMETH.KSMP.SetB0Map(B0Map);
    SIMMETH.KSMP.SetDelay(B0MAP.Delay);
end

%==================================================================
% AddPostEffect
%==================================================================  
function [SampDat,err] = AddPostEffect(B0MAP,SIMMETH,STCH,SampDat)
    
    err.flag = 0; 
    % Dummy
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    B0MAP.Panel(1,:) = {'','','Output'};
    B0MAP.Panel(2,:) = {'EffectFunc',B0MAP.Method,'Output'};
    B0MAP.Panel(3,:) = {'SphereDiam (mm)',B0MAP.SphereDiam,'Output'};
    B0MAP.Panel(4,:) = {'Delay (ms)',B0MAP.Delay,'Output'};
    B0MAP.Panel(5,:) = {'OffRes (Hz)',B0MAP.OffRes,'Output'};
    B0MAP.Panel(6,:) = {'FiltVox (mm)',B0MAP.FiltVox,'Output'};
    B0MAP.Panel(7,:) = {'FiltBeta',B0MAP.FiltBeta,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end





