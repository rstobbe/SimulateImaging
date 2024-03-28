%===========================================
% 
%===========================================

function [B0MAP,err] = B0MapOffResSphere_v1c_Func(B0MAP,INPUT)

Status2('busy','Create B0 Map',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
if isfield(INPUT,'ObMatSz')
    ObMatSz = INPUT.ObMatSz;
else
    ObMatSz = INPUT.OB.ObMatSz; 
end
clear INPUT;

%---------------------------------------------
% Get Input
%---------------------------------------------
map = zeros([ObMatSz,ObMatSz,ObMatSz]);
C = ObMatSz/2;
for n = -B0MAP.spherediam:B0MAP.spherediam
    for m = -B0MAP.spherediam:B0MAP.spherediam
        for p = -B0MAP.spherediam:B0MAP.spherediam
            rad = sqrt(n^2 + m^2 + p^2);
            if rad <= B0MAP.spherediam
                map(n+C+B0MAP.xshift,m+C+B0MAP.yshift,p+C+B0MAP.zshift) = B0MAP.offres;
            end
        end
    end
end
B0MAP.map = map;

%---------------------------------------------
% Panel Output
%---------------------------------------------
Panel(1,:) = {'B0MapMethod',B0MAP.method,'Output'};
Panel(2,:) = {'SphereDiam',B0MAP.spherediam,'Output'};
Panel(3,:) = {'OffRes',B0MAP.offres,'Output'};
PanelOutput = cell2struct(Panel,{'label','value','type'},2);
B0MAP.Panel = Panel;
B0MAP.PanelOutput = PanelOutput;
