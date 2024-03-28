%===========================================
%
%===========================================

function [SAMP,err] = kSpaceSample_v3b_Func(INPUT,SAMP)

Status('busy','Sample k-Space');
Status2('done','',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
OB = INPUT.OB;
IMP = INPUT.IMP;
KSMP = INPUT.KSMP;
EFCT = INPUT.EFCT;
clear INPUT;

%----------------------------------------------------
% Get Sampling Info
%----------------------------------------------------
ZF = KSMP.IFprms.ZF;
SS = KSMP.IFprms.SS;

%----------------------------------------------------
% Build Object
%----------------------------------------------------
func = str2func([SAMP.ObjectFunc,'_Func']);  
INPUT.IMP = IMP;
INPUT.ZF = ZF;
INPUT.SS = SS;
[OB,err] = func(OB,INPUT);
if err.flag
    return
end
clear INPUT;

%---------------------------------------------
% Effect (on traj)
%---------------------------------------------
func = str2func([SAMP.EffectAddFunc,'_Func']);  
INPUT.IMP = IMP;
INPUT.OB = OB;
INPUT.prepostsamp = 'pre';
[EFCT,err] = func(EFCT,INPUT);
if isfield(EFCT,'IMP')
    IMP = EFCT.IMP;
end
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
    if isfield(EFCT,'B0map')
        B0Map = EFCT.B0map;
        INPUT.Image(:,:,:,2) = B0Map(:,:,start:stop);
        PlotMontageOverlay_v1e(INPUT);
    else
        B0Map = 0;
        PlotMontageImage_v1e(INPUT);
    end
    clear INPUT;
end

button = questdlg('Continue?');
if strcmp(button,'No') || strcmp(button,'Cancel')
    err.flag = 4;
    return
end

%---------------------------------------------
% Orient
%---------------------------------------------
OB.Ob = permute(OB.Ob,[2 1 3 4]);                        

%==========================================================
% Array 
%==========================================================
sz = size(OB.Ob);
if length(sz) == 3
    ObArr = 1;
else
    ObArr = sz(4);
end

sz = size(IMP.Kmat);
if length(sz) == 3
    SampArr = 1;
else
    SampArr = sz(4);
end
Kmat0 = IMP.Kmat;
if not(isfield(IMP,'projsampscnr'))
    IMP.projsampscnr = (1:IMP.PROJimp.nproj);
end
SampDat = zeros([length(IMP.projsampscnr),sz(2),SampArr]);
for m = 1:ObArr
    for n = 1:SampArr
 
        Panel(1,:) = {'','','Output'};
        Panel(2,:) = {'Object Number',m,'Output'};
        PanelOutput = cell2struct(Panel,{'label','value','type'},2);
        
        IMP.Kmat = squeeze(Kmat0(:,:,:,n));

        %---------------------------------------------
        % Sample
        %---------------------------------------------
        func = str2func([SAMP.SampleFunc,'_Func']);  
        INPUT.IMP = IMP;
        INPUT.Ob = OB.Ob(:,:,:,m);
        INPUT.B0Map = B0Map;
        INPUT.MaskFoV = 'No';
        [KSMP,err] = func(KSMP,INPUT);
        if err.flag
            return
        end
        clear INPUT;

        %---------------------------------------------
        % Effect (on data)
        %---------------------------------------------
        func = str2func([SAMP.EffectAddFunc,'_Func']);  
        INPUT.IMP = IMP;
        INPUT.ObArrNum = m;
        INPUT.OB = OB;
        INPUT.KSMP = KSMP;
        INPUT.prepostsamp = 'post';
        [EFCT,err] = func(EFCT,INPUT);
        if err.flag
            return
        end
        if m == 1
            SampDat(:,:,n) = DatArr2Mat(EFCT.SampDat,length(IMP.projsampscnr),IMP.PROJimp.npro);
            EfctPanelOutput = [PanelOutput;EFCT.PanelOutput];
        else
            SampDat(:,:,n) = SampDat(:,:,n) + DatArr2Mat(EFCT.SampDat,length(IMP.projsampscnr),IMP.PROJimp.npro);
            EfctPanelOutput = [EfctPanelOutput;PanelOutput;EFCT.PanelOutput];
        end
        clear INPUT;
    end
end

%---------------------------------------------
% Panel
%---------------------------------------------
Panel(1,:) = {'','','Output'};
Panel(2,:) = {'ImpFile',IMP.name,'Output'};
Panel(3,:) = {'KernFile',KSMP.KRNprms.name,'Output'};
Panel(4,:) = {'InvFiltFile',KSMP.IFprms.name,'Output'};
PanelOutput = cell2struct(Panel,{'label','value','type'},2);
SAMP.PanelOutput = PanelOutput;
SAMP.PanelOutput = [SAMP.PanelOutput;OB.PanelOutput;EfctPanelOutput];

%---------------------------------------------
% Return
%---------------------------------------------
SAMP.SampDat = SampDat;
OB = rmfield(OB,'Ob');
SAMP.OB = OB;
SAMP.ZF = KSMP.ZF;

Status2('done','',1);
Status2('done','',2);
Status2('done','',3);


