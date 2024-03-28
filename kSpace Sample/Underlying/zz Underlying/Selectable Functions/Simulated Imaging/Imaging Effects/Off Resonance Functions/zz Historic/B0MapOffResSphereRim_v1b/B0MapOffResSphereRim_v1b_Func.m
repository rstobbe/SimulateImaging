%===========================================
% 
%===========================================

function [B0MAP,err] = B0MapOffResSphereRim_v1b_Func(B0MAP,INPUT)

Status2('busy','Create B0 Map',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
ObMatSz = INPUT.OB.ObMatSz;
PixWidth = INPUT.OB.PixWidth;
clear INPUT;

%---------------------------------------------
% Get Input
%---------------------------------------------
spherediammat = B0MAP.spherediam/PixWidth;
rimthickmat = B0MAP.rimthick/PixWidth;
offres = B0MAP.offres;

map = zeros([ObMatSz,ObMatSz,ObMatSz]);
CX = (ObMatSz+1)/2;
CY = (ObMatSz+1)/2;
CZ = (ObMatSz+1)/2;
for x = 1:ObMatSz
    for y = 1:ObMatSz
        for z = 1:ObMatSz
            rad = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if rad > (spherediammat/2-rimthickmat) && rad <= (spherediammat/2)
                map(z,x,y) = offres;
            end
        end
    end
end

%---------------------------------------------
% Return
%---------------------------------------------
B0MAP.map = map;              
B0MAP.maxoff = max(B0MAP.map(:));

%---------------------------------------------
% Panel Output
%---------------------------------------------
Panel(1,:) = {'B0MapMethod',B0MAP.method,'Output'};
B0MAP.Panel = Panel;
B0MAP.PanelOutput = cell2struct(B0MAP.Panel,{'label','value','type'},2);

