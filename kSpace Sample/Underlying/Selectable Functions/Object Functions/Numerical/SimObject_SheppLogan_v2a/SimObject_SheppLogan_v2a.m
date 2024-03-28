%==================================================================
% (v2a)
%   
%==================================================================

classdef SimObject_SheppLogan_v2a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_SheppLogan_v2a'
    LongDim
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
function [SIMOB,err] = SimObject_SheppLogan_v2a(SIMOBipt)    
    err.flag = 0;
    SIMOB.LongDim = str2double(SIMOBipt.('LongDim'));
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
    % Test
    %---------------------------------------------
    M = SIMMETH.KSMP.IF.ZF;
    MatDim = 2*round(((SIMOB.LongDim/SIMOB.PixWidth)/0.90625)/2);              % Phantom always created inset

    %--------------------------------------
    % Create Phantom
    %--------------------------------------
    SIMOB.SimOb = zeros(M,M,M);
    Phantom = phantom3d(MatDim);
    bot = (M - MatDim)/2 + 1;
    top = bot + MatDim - 1;
    SIMOB.SimOb(bot:top,bot:top,bot:top) = Phantom;
    
    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = ['SheppLogan',num2str(SIMOB.LongDim)];

    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIMOB.Panel(1,:) = {'',[],'Output'};
    SIMOB.Panel(2,:) = {'ObFunc',SIMOB.Method,'Output'};
    SIMOB.Panel(3,:) = {'SheppLoganLongDim (mm)',SIMOB.LongDim,'Output'};
    
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











