%==================================================================
% (v2b)
%       - update for multiple KINFO
%==================================================================

classdef SimMeth_Psf_v2b < handle

properties (SetAccess = private)                   
    Method = 'SimMeth_Psf_v2b'
    SampDat
    ZF
    Panel = cell(0)
    PanelOutput
    ExpDisp
end
properties (SetAccess = public)    
    name
    path
    saveSCRPTcellarray
end

methods 
   
%==================================================================
% Constructor
%==================================================================  
function [SIMMETH,err] =  SimMeth_Psf_v2b(SIMMETHipt)    
    err.flag = 0;   
end 

%==================================================================
% Write
%================================================================== 
function err = Simulate(SIMMETH,WRT)
    err.flag = 0;
    for n = 1:length(WRT.STCH)
        STCH = WRT.STCH{n};
        sz = size(STCH.ReconInfoMat);
        SIMMETH.SampDat{n} = zeros(sz(1)*2,sz(2),'single');
        SIMMETH.SampDat{n}(1:2:end-1,:) = ones(sz(1),sz(2),'single');
        SIMMETH.SampDat{n}(2:2:end,:) = zeros(sz(1),sz(2),'single');
    end
    SIMMETH.name = 'Psf';
    SIMMETH.ZF = 1000;
    
    %---------------------------------------------
    % Panel
    %---------------------------------------------
    Panel0(1,:) = {'','','Output'};
    Panel0(2,:) = {'WrtFile',STCH.name,'Output'};
    SIMMETH.Panel = Panel0; 
    SIMMETH.PanelOutput = cell2struct(SIMMETH.Panel,{'label','value','type'},2);
    SIMMETH.ExpDisp = PanelStruct2Text(SIMMETH.PanelOutput);
    
    Status2('done','',1);
    Status2('done','',2);
    Status2('done','',3);
end

end
end






