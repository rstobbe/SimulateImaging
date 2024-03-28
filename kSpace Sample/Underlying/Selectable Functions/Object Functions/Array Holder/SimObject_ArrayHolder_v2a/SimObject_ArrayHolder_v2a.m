%==================================================================
% (v2a)
%   
%==================================================================

classdef SimObject_ArrayHolder_v2a < handle

properties (SetAccess = private)                   
    Method = 'SimObject_ArrayHolder_v2a'
    ObMatSz
    SimOb
    PixWidth
    Rcvrs
    name
    Panel = cell(0);
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIMOB,err] = SimObject_ArrayHolder_v2a(Rcvrs)    
    err.flag = 0;
    SIMOB.Rcvrs = Rcvrs;
end

%==================================================================
% SetObject
%==================================================================  
function SetObject(SIMOB,Object)
    SIMOB.SimOb = Object;  
end

%==================================================================
% SetPanel
%==================================================================  
function SetPanel(SIMOB,Panel)
    SIMOB.Panel = Panel;  
end

%==================================================================
% SetName
%==================================================================  
function SetName(SIMOB,Name)
    SIMOB.name = Name;  
end

%==================================================================
% SetPixWidth
%==================================================================  
function SetPixWidth(SIMOB,PixWidth)
    SIMOB.PixWidth = PixWidth;  
end

%==================================================================
% SetObMatSz
%==================================================================  
function SetObMatSz(SIMOB,ObMatSz)
    SIMOB.ObMatSz = ObMatSz;  
end

%==================================================================
% PlotSimObject
%==================================================================  
function err = PlotSimObject(SIMOB,SIMMETH)
    err.flag = 0;
    Status2('busy','Plot Object',2);
    sz = size(SIMOB.SimOb);
    start = round(sz(3)*0.1);
    stop = round(sz(3)*0.9);
    %for n = 1
%     for n = 1:SIMOB.Rcvrs
%         INPUT.Image = SIMOB.SimOb(:,:,start:stop,n);
%         INPUT.numberslices = 28;
%         [MCHRS,err] = DefaultMontageChars_v1a(INPUT);
%         fh = figure(100+n);
%         MCHRS.MSTRCT.fhand = fh;
%         MCHRS.MSTRCT.dispwid = [0 1];
%         INPUT = MCHRS;
%         INPUT.Image = flip(INPUT.Image,2);
%         if isprop(SIMMETH.KSMP,'B0Map')
%             INPUT.Image(:,:,:,2) = SIMMETH.KSMP.B0Map(:,:,start:stop);
%             INPUT.MSTRCT.colour2 = 'Yes';
%             PlotMontageOverlay_v1e(INPUT);
%         else
%             PlotMontageImage_v1e(INPUT);
%         end
%     end
end

end
end











