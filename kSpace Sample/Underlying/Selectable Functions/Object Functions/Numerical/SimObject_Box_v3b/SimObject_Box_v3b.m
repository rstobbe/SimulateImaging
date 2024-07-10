%==================================================================
% (v3b)
%       - update for external run
%==================================================================

classdef SimObject_Box_v3b < handle

properties (SetAccess = private)                   
    Method = 'SimObject_Box_v3a'
    XDim0,YDim0,ZDim0
    XDim,YDim,ZDim
    ObMatSz
    PixWidth
    name
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function SIMOB = SimObject_Box_v3b()      
end

%==================================================================
% InitViaCompass
%==================================================================  
function InitViaCompass(SIMOB,SIMOBipt)    
    SIMOB.XDim0 = str2double(SIMOBipt.('XDim'));
    SIMOB.YDim0 = str2double(SIMOBipt.('YDim'));
    SIMOB.ZDim0 = str2double(SIMOBipt.('ZDim'));    
end

%==================================================================
% SetBoxDimensions
%================================================================== 
function SetBoxDimensions(SIMOB,x,y,z)    
    SIMOB.XDim0 = x;
    SIMOB.YDim0 = y;
    SIMOB.ZDim0 = z; 
end

%==================================================================
% BuildSimObject
%==================================================================  
function err = BuildSimObject(SIMOB,SIMMETH,STCH)
    err.flag = 0;
    
    Status2('busy','Create Box Object',2);
    Status2('done','',3);

    %---------------------------------------------
    % PixWidth
    %---------------------------------------------
    SIMOB.PixWidth = STCH.Fov/SIMMETH.KSMP.BaseMatrix;
    
    %--------------------------------------
    % Create Box
    %--------------------------------------
    M = SIMMETH.KSMP.BaseMatrix;
    SimOb = zeros(M,M,M);
    XPix = round(SIMOB.XDim0/SIMOB.PixWidth);
    YPix = round(SIMOB.YDim0/SIMOB.PixWidth);
    ZPix = round(SIMOB.ZDim0/SIMOB.PixWidth);    
    SIMOB.XDim = XPix*SIMOB.PixWidth;
    SIMOB.YDim = YPix*SIMOB.PixWidth;
    SIMOB.ZDim = ZPix*SIMOB.PixWidth;  
    
    XBot = M/2 - round(XPix/2);
    XTop = XBot + XPix - 1;
    YBot = M/2 - round(YPix/2);
    YTop = YBot + YPix - 1;
    ZBot = M/2 - round(ZPix/2);
    ZTop = ZBot + ZPix - 1;
    SimOb(XBot:XTop,YBot:YTop,ZBot:ZTop) = 1;
    
    SIMMETH.KSMP.SetImage(SimOb);
    
    %---------------------------------------------
    % Return
    %---------------------------------------------
    SIMOB.ObMatSz = M;
    SIMOB.name = ['Box','X',num2str(SIMOB.XDim0),'Y',num2str(SIMOB.YDim0),'Z',num2str(SIMOB.ZDim0)];
    ind = strfind(SIMOB.name,'.');
    SIMOB.name(ind) = 'p';
    
    %---------------------------------------------
    % Panel Output
    %--------------------------------------------- 
    SIMOB.Panel(1,:) = {'',[],'Output'};
    SIMOB.Panel(2,:) = {'ObFunc',SIMOB.Method,'Output'};
    SIMOB.Panel(3,:) = {'XDim (mm)',SIMOB.XDim,'Output'};
    SIMOB.Panel(4,:) = {'YDim (mm)',SIMOB.YDim,'Output'};
    SIMOB.Panel(5,:) = {'ZDim (mm)',SIMOB.ZDim,'Output'};    
    
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











