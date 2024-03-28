%===========================================
% 
%===========================================

function [B0MAP,err] = B0MapOffResSphereRim_v1a_Func(B0MAP,INPUT)

Status2('busy','Create B0 Map',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
ObMatSz = INPUT.OB.ObMatSz;
SampFoV = INPUT.IMP.PROJdgn.fov;
clear INPUT;

%---------------------------------------------
% Get Input
%---------------------------------------------
map = zeros([ObMatSz,ObMatSz,ObMatSz]);
CX = (ObMatSz+1)/2;
CY = (ObMatSz+1)/2;
CZ = (ObMatSz+1)/2;
for x = 1:ObMatSz
    for y = 1:ObMatSz
        for z = 1:ObMatSz
            rad = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if rad > (B0MAP.spherediam/2-B0MAP.rimthick)*(ObMatSz/SampFoV) && rad <= (B0MAP.spherediam/2)*(ObMatSz/SampFoV)
                map(z,x,y) = B0MAP.offres;
            end
        end
    end
end

%---------------------------------------------
% Return
%---------------------------------------------
vox = SampFoV/ObMatSz;
B0MAP.map = map;              
B0MAP.maxoff = max(B0MAP.map(:));

%---------------------------------------------
% Panel Output
%---------------------------------------------
Panel(1,:) = {'B0MapMethod',B0MAP.method,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
B0MAP.PanelOutput = PanelOutput;
