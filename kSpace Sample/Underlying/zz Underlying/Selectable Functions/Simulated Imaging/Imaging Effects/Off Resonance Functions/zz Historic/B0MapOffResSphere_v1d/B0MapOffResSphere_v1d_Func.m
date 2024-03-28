%===========================================
% 
%===========================================

function [B0MAP,err] = B0MapOffResSphere_v1d_Func(B0MAP,INPUT)

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
if isfield(INPUT,'SampFoV')
    SampFoV = INPUT.SampFoV;
else 
    SampFoV = INPUT.IMP.PROJdgn.fov;
end
LPASS = B0MAP.LPASS;
clear INPUT;

%---------------------------------------------
% Get Input
%---------------------------------------------
map = zeros([ObMatSz,ObMatSz,ObMatSz]);
C = ObMatSz/2;
for n = -B0MAP.spherediam/2:B0MAP.spherediam/2
    for m = -B0MAP.spherediam/2:B0MAP.spherediam/2
        for p = -B0MAP.spherediam/2:B0MAP.spherediam/2
            rad = sqrt(n^2 + m^2 + p^2);
            if rad <= B0MAP.spherediam/2
                map(n+C+B0MAP.xshift,m+C+B0MAP.yshift,p+C+B0MAP.zshift) = B0MAP.offres;
            end
        end
    end
end

%---------------------------------------------
% Low Pass Filter
%---------------------------------------------
vox = SampFoV/ObMatSz;
IMG.ReconPars.ImvoxTB = vox;
IMG.ReconPars.ImvoxLR = vox;
IMG.ReconPars.ImvoxIO = vox;
IMG.ReconPars.ImfovTB = SampFoV;
IMG.ReconPars.ImfovLR = SampFoV;
IMG.ReconPars.ImfovIO = SampFoV;
IMG.Im = map;

func = str2func([B0MAP.lpassfunc,'_Func']);  
INPUT.IMG = IMG;
[LPASS,err] = func(LPASS,INPUT);
if err.flag
    return
end
clear INPUT;
B0MAP.map = abs(LPASS.Im);              % LPF can introduce phase change...
B0MAP.maxoff = max(B0MAP.map(:));

%---------------------------------------------
% Panel Output
%---------------------------------------------
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'B0MapMethod',B0MAP.method,'Output'};
Panel(3,:) = {'Fov (mm)',SampFoV,'Output'};
Panel(4,:) = {'MatSz (mat)',ObMatSz,'Output'};
Panel(5,:) = {'Voxels (mm)',vox,'Output'};
Panel(6,:) = {'SphereDiam (mat)',B0MAP.spherediam,'Output'};
Panel(7,:) = {'SphereDiam (mm)',B0MAP.spherediam*vox,'Output'};
Panel(8,:) = {'Xshift (mm)',B0MAP.xshift*vox,'Output'};
Panel(9,:) = {'Yshift (mm)',B0MAP.yshift*vox,'Output'};
Panel(10,:) = {'Zshift (mm)',B0MAP.zshift*vox,'Output'};
Panel(11,:) = {'MaxOffRes (Hz)',B0MAP.maxoff,'Output'};
Panel(12,:) = {'',[],'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
B0MAP.Panel = Panel;
B0MAP.PanelOutput = [PanelOutput;LPASS.PanelOutput];
