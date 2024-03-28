%===========================================
% 
%===========================================

function [B0MAP,err] = B0MapOffResCircle_v1a_Func(B0MAP,INPUT)

Status2('busy','Create B0 Map',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
OB = INPUT.OB;
clear INPUT;

%---------------------------------------------
% Get Input
%---------------------------------------------
map = zeros(size(OB.Ob));
C = OB.ObMatSz/2;
for n = -B0MAP.circlediam:B0MAP.circlediam
    for m = -B0MAP.circlediam:B0MAP.circlediam
        rad = sqrt(n^2 + m^2);
        if rad <= B0MAP.circlediam
            map(n+C,m+C) = B0MAP.offres;
        end
    end
end
B0MAP.map = map;

% figure(100);
% imshow(map);
