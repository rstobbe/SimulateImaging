%==================================================================
% (v3a)
%   
%==================================================================

classdef SimObject_Rand1_v1a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_Rand1_v1a'
    ObMatSz
    PixWidth
    name
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function SIMOB = SimObject_Rand1_v1a()    
end

%==================================================================
% InitViaCompass
%==================================================================  
function InitViaCompass(SIMOB,SIMOBipt)       
end

%==================================================================
% BuildSimObject
%==================================================================  
function err = BuildSimObject(SIMOB,SIMMETH,STCH)
    err.flag = 0;
    
    Status2('busy','Create Random Object (Full Size)',2);
    Status2('done','',3);

    %---------------------------------------------
    % PixWidth
    %---------------------------------------------
    SIMOB.PixWidth = STCH.Fov/SIMMETH.KSMP.BaseMatrix;
    
    %--------------------------------------
    % Create Random Object
    %--------------------------------------
    M = SIMMETH.KSMP.BaseMatrix;
    SimOb = rand(M,M,M);
    SIMMETH.KSMP.SetImage(SimOb);

    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = 'Rand1';
    
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











