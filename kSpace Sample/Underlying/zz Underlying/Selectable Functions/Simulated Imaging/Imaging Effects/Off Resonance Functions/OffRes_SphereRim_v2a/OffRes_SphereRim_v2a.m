%==================================================================
% (v2a)
%   
%==================================================================

classdef OffRes_SphereRim_v2a < handle

properties (SetAccess = private)                   
    Method = 'OffRes_SphereRim_v2a'
    OffRes
    RimThick
    SphereDiam
    Delay
    Panel = cell(0)
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [B0MAP,err] = OffRes_SphereRim_v2a(B0MAPipt)    
    err.flag = 0;
    B0MAP.SphereDiam = str2double(B0MAPipt.('SphereDiam'));
    B0MAP.RimThick = str2double(B0MAPipt.('RimThick'));
    B0MAP.OffRes = str2double(B0MAPipt.('OffRes'));
    B0MAP.Delay = str2double(B0MAPipt.('Delay'));
end

%==================================================================
% AddPreEffect
%==================================================================  
function AddPreEffect(B0MAP,SIMMETH)

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
    RimThickMat = B0MAP.RimThick/PixWidth;

    B0Map = zeros([ObMatSz,ObMatSz,ObMatSz]);
    CX = (ObMatSz+1)/2;
    CY = (ObMatSz+1)/2;
    CZ = (ObMatSz+1)/2;
    for x = 1:ObMatSz
        for y = 1:ObMatSz
            for z = 1:ObMatSz
                rad = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                if rad > (SphereDiamMat/2-RimThickMat) && rad <= (SphereDiamMat/2)
                    B0Map(z,x,y) = B0MAP.OffRes;
                end
            end
        end
    end
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
    B0MAP.Panel(2,:) = {'Method',B0MAP.Method,'Output'};
    B0MAP.Panel(3,:) = {'SphereDiam (mm)',B0MAP.SphereDiam,'Output'};
    B0MAP.Panel(4,:) = {'RimThick (mm)',B0MAP.RimThick,'Output'};
    B0MAP.Panel(5,:) = {'Delay (ms)',B0MAP.Delay,'Output'};
    B0MAP.Panel(6,:) = {'OffRes (Hz)',B0MAP.OffRes,'Output'};
    
    Status2('done','',2);
    Status2('done','',3);
end


end
end





