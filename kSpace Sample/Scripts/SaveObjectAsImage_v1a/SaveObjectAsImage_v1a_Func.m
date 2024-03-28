%===========================================
%
%===========================================

function [IMG,err] = SaveObjectAsImage_v1a_Func(INPUT,IMG)

Status('busy','Save Object As Image');
Status2('done','',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
OB = INPUT.OB;
clear INPUT;

%----------------------------------------------------
% Build Object
%----------------------------------------------------
func = str2func([IMG.ObjectFunc,'_Func']);  
INPUT.IMP.PROJdgn.fov = IMG.FoV;
INPUT.ZF = IMG.ZeroFill;
INPUT.SS = IMG.SubSamp;
[OB,err] = func(OB,INPUT);
if err.flag
    return
end
clear INPUT;

%---------------------------------------------
% Plot
%---------------------------------------------
plotob = 1;
if plotob == 1
    Status2('busy','Plot Object',2);
    sz = size(OB.Ob);
%     start = round(((SS-1)/3)*sz(3));
%     stop = sz(3)-round(((SS-1)/3)*sz(3))+1;
    start = round(sz(3)*0.1);
    stop = round(sz(3)*0.9);
    if isfield(OB,'plot')
        if strcmp(OB.plot,'CentreSlice')
            INPUT.Image = OB.Ob(:,:,sz(3)/2,1);
            INPUT.numberslices = 1;
        else
            INPUT.Image = OB.Ob(:,:,start:stop,1);
            INPUT.numberslices = 28;
        end
    else
        INPUT.Image = OB.Ob(:,:,start:stop,1);
        INPUT.numberslices = 28;
    end
    [MCHRS,err] = DefaultMontageChars_v1a(INPUT);
    MCHRS.MSTRCT.figno = 100;
    INPUT = MCHRS;
    INPUT.Image = flip(INPUT.Image,2);
    PlotMontageImage_v1e(INPUT);
    clear INPUT;
end

%---------------------------------------------
% Panel
%---------------------------------------------
IMG.PanelOutput = OB.PanelOutput;
IMG.ExpDisp = PanelStruct2Text(IMG.PanelOutput);

%----------------------------------------------
% Set Up Compass Display
%----------------------------------------------
MSTRCT.type = 'abs';
MSTRCT.dispwid = [0 max(abs(OB.Ob(:)))];
MSTRCT.ImInfo.pixdim = [OB.pixdim,OB.pixdim,OB.pixdim];
MSTRCT.ImInfo.vox = OB.vox;
MSTRCT.ImInfo.info = IMG.ExpDisp;
MSTRCT.ImInfo.baseorient = 'Axial';             % all images should be oriented axially
INPUT.Image = OB.Ob;
INPUT.MSTRCT = MSTRCT;
IMDISP = ImagingPlotSetup(INPUT);
IMG.IMDISP = IMDISP;

%---------------------------------------------
% Return
%---------------------------------------------
IMG.Im = OB.Ob;
OB = rmfield(OB,'Ob');
IMG.OB = OB;

Status2('done','',1);
Status2('done','',2);
Status2('done','',3);


