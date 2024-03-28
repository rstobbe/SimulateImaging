%===========================================
% 
%===========================================

function [OB,err] = SimMeovPhanFlexible_v2a_Func(OB,INPUT)

Status2('busy','Create Numerical Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Input
%---------------------------------------------
IMP = INPUT.IMP;
PROJdgn = IMP.PROJdgn;
ZF = INPUT.ZF;
SS = INPUT.SS;
clear INPUT;

%---------------------------------------------
% Object Matrix as big as possible
%---------------------------------------------
M = ZF;

%--------------------------------------
% Inner Spheres
%--------------------------------------
Ob = zeros(M,M,M);
OB.SphereRelDiam = (OB.SphereDiam/PROJdgn.fov)/SS;
OB.ResRelDiam1 = (OB.ResDiam1/PROJdgn.fov)/SS;
OB.ResRelDiam2 = (OB.ResDiam2/PROJdgn.fov)/SS;
OB.ResRelDiam3 = (OB.ResDiam3/PROJdgn.fov)/SS;
OB.ResRelDiam4 = (OB.ResDiam4/PROJdgn.fov)/SS;
OB.ResRelDiam5 = (OB.ResDiam5/PROJdgn.fov)/SS;
OB.ResRelDiam6 = (OB.ResDiam6/PROJdgn.fov)/SS;
OB.ResRelDiam7 = (OB.ResDiam7/PROJdgn.fov)/SS;
OB.ResRelDiam8 = (OB.ResDiam8/PROJdgn.fov)/SS;
OB.ResRelDiam9 = (OB.ResDiam9/PROJdgn.fov)/SS;
OB.RelSepDist = (OB.SepDist/PROJdgn.fov)/SS;
rmax = (M/2)*OB.SphereRelDiam;
rmax1 = (M/2)*OB.ResRelDiam1;
rmax2 = (M/2)*OB.ResRelDiam2;
rmax3 = (M/2)*OB.ResRelDiam3;
rmax4 = (M/2)*OB.ResRelDiam4;
rmax5 = (M/2)*OB.ResRelDiam5;
rmax6 = (M/2)*OB.ResRelDiam6;
rmax7 = (M/2)*OB.ResRelDiam7;
rmax8 = (M/2)*OB.ResRelDiam8;
rmax9 = (M/2)*OB.ResRelDiam9;
SepDist = (M/2)*OB.RelSepDist;
%shift = round((M/2)*(4.5/PROJdgn.fov)/SS);
CX = M/2;
CY = M/2;
CZ = M/2;

for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r < rmax
                Ob(y,x,z) = OB.BigSphereMag;
            end
        end
    end
end

ys = round((rmax1-rmax7)*1.3);
xs = -round((rmax1-rmax3)*1.3);
for x = 1:M
    for y = 1:M
        for z = 1:M
            r = sqrt((x-CX)^2 + (y-CY)^2 + (z-CZ)^2);
            if r <= rmax1
                Ob(y-round(SepDist+rmax1+rmax4)+ys,x-round(SepDist+rmax1+rmax2)-xs,z) = OB.MeovSphereMag;         
            end
            if r <= rmax2
                Ob(y-round(SepDist+rmax1+rmax4)+ys,x-xs,z) = OB.MeovSphereMag;           
            end
            if r <= rmax3
                Ob(y-round(SepDist+rmax1+rmax4)+ys,x+round(SepDist+rmax3+rmax2)-xs,z) = OB.MeovSphereMag;           
            end
            if r <= rmax4
                Ob(y+ys,x-round(SepDist+rmax1+rmax2)-xs,z) = OB.MeovSphereMag;           
            end
            if r <= rmax5
                Ob(y+ys,x-xs,z) = OB.MeovSphereMag;          
            end
            if r <= rmax6
                Ob(y+ys,x+round(SepDist+rmax3+rmax2)-xs,z) = OB.MeovSphereMag;          
            end            
            if r <= rmax7
                Ob(y+round(SepDist+rmax7+rmax4)+ys,x-round(SepDist+rmax1+rmax2)-xs,z) = OB.MeovSphereMag;          
            end
            if r <= rmax8
                Ob(y+round(SepDist+rmax7+rmax4)+ys,x-xs,z) = OB.MeovSphereMag;            
            end
            if r <= rmax9
                Ob(y+round(SepDist+rmax7+rmax4)+ys,x+round(SepDist+rmax3+rmax2)-xs,z) = OB.MeovSphereMag;           
            end
        end
    end
end

Ob = flip(Ob,2);

%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;
OB.name = 'SimMeovPhan';
OB.plot = 'CentreSlice';

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'',[],'Output'};
Panel(2,:) = {'ObFunc',OB.method,'Output'};
Panel(3,:) = {'SphereDiam (mm)',OB.SphereDiam,'Output'};
Panel(4,:) = {'ResDiam1 (mm)',OB.ResDiam1,'Output'};
Panel(5,:) = {'ResDiam2 (mm)',OB.ResDiam2,'Output'};
Panel(6,:) = {'ResDiam3 (mm)',OB.ResDiam3,'Output'};
Panel(7,:) = {'ResDiam4 (mm)',OB.ResDiam4,'Output'};
Panel(8,:) = {'ResDiam5 (mm)',OB.ResDiam5,'Output'};
Panel(9,:) = {'SepDist (mm)',OB.SepDist,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

