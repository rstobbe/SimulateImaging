%==================================================================
% (v2a)
%   
%==================================================================

classdef SimObject_SphereLinPhase_v2a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_SphereLinPhase_v2a'
    Start
    Periods
    Dimension
    SphereDiam
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
function [SIMOB,err] = SimObject_SphereLinPhase_v2a(SIMOBipt)    
    err.flag = 0;
    SIMOB.SphereDiam = str2double(SIMOBipt.('SphereDiam'));
    SIMOB.Start = str2double(SIMOBipt.('Start'));
    SIMOB.Periods = str2double(SIMOBipt.('Periods'));
    SIMOB.Dimension = SIMOBipt.('Dimension');
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
    SIMOB.RelDiam = (SIMOB.SphereDiam/WRT.STCH{1}.Fov)/SIMMETH.KSMP.IF.SS;

    %---------------------------------------------
    % Test
    %---------------------------------------------
    M = SIMMETH.KSMP.IF.ZF;

    %--------------------------------------
    % Create Head
    %--------------------------------------
    SIMOB.SimOb = complex(zeros(M,M,M),zeros(M,M,M));
    rmax = (M/2)*SIMOB.RelDiam;
    CX = (M+1)/2;
    CY = (M+1)/2;
    CZ = (M+1)/2;
    for x = 1:M
        for y = 1:M
            for z = 1:M
                r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
                if r <= rmax
                    SIMOB.SimOb(z,x,y) = 1;
                end
            end
        end
       Status2('busy',x,2);
    end

    val0 = exp(1i*2*pi*(SIMOB.Periods*((1:M)/M)+SIMOB.Start/2)).'; 
    if strcmp(SIMOB.Dimension,'x')
        val(:,1,1) = val0;
        Phase = repmat(val,1,M,M);
    elseif strcmp(SIMOB.Dimension,'y')
        val(1,:,1) = val0;
        Phase = repmat(val,M,1,M);
    elseif strcmp(SIMOB.Dimension,'z')
        val(1,1,:) = val0;
        Phase = repmat(val,M,M,1);  
    end
    SIMOB.SimOb = SIMOB.SimOb .* Phase;
    
    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = ['Sphere',num2str(SIMOB.SphereDiam),'LinPhase',num2str(SIMOB.Periods)];

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
    sz = size(SIMOB.SimOb);
    start = round(sz(3)*0.1);
    stop = round(sz(3)*0.9);
    INPUT.Image = abs(SIMOB.SimOb(:,:,start:stop,1));
    INPUT.numberslices = 28;
    [MCHRS,err] = DefaultMontageChars_v1a(INPUT);
    fh = figure(100);
    MCHRS.MSTRCT.fhand = fh;
    INPUT = MCHRS;
    INPUT.Image = flip(INPUT.Image,2);
    INPUT.Image(:,:,:,2) = angle(SIMOB.SimOb(:,:,start:stop));
    INPUT.MSTRCT.colour2 = 'Yes';
    PlotMontageOverlay_v1e(INPUT);
%     if isprop(SIMMETH.KSMP,'B0Map')
%         INPUT.Image(:,:,:,2) = SIMMETH.KSMP.B0Map(:,:,start:stop);
%         INPUT.MSTRCT.colour2 = 'Yes';
%         PlotMontageOverlay_v1e(INPUT);
%     else
%         PlotMontageImage_v1e(INPUT);
%     end
end



end
end











