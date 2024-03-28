%===========================================
% 
%===========================================

function [OB,err] = ModSheppLogan_v1a_Func(OB,INPUT)

Status2('busy','Create Numerical Object',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Test
%---------------------------------------------
M = OB.ObMatSz;

%---------------------------------------------
% Create
%---------------------------------------------
Ob = phantom('Modified Shepp-Logan',M);

%---------------------------------------------
% Max Displacement
%---------------------------------------------
MaxDisp = 0;
C = (M+1)/2;
for x = 1:M
    for y = 1:M
        r = sqrt((x-C)^2 + (y-C)^2);
        if Ob(x,y) == 1
            if r > MaxDisp
                MaxDisp = r;
            end
        end
    end
end
            
%---------------------------------------------
% Return
%---------------------------------------------
OB.Ob = Ob;
OB.ObMatSz = M;

%---------------------------------------------
% Panel Output
%--------------------------------------------- 
Panel(1,:) = {'ObMatSz',OB.ObMatSz,'Output'};

PanelOutput = cell2struct(Panel,{'label','value','type'},2);
OB.PanelOutput = PanelOutput;

Status2('done','',2);
Status2('done','',3);

