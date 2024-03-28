%===========================================
% (v1e)
%      - Calling Update
%===========================================

function [SCRPTipt,KSMP,ReturnData,err] = kSampGrdCudaDoubles_v1e(SCRPTipt,KSMPipt)

Status2('busy','Get Sampling Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

KSMP = struct();
CallingLabel = KSMPipt.Struct.labelstr;
PanelLabel1 = 'Kern_File';
PanelLabel2 = 'InvFilt_File';
ReturnData = [];

%---------------------------------------------
% Tests
%---------------------------------------------
LoadAll = 0;
if not(isfield(KSMPipt,[CallingLabel,'_Data']))
    LoadAll = 1;
end
if LoadAll == 1 || not(isfield(KSMPipt.([CallingLabel,'_Data']),[PanelLabel1,'_Data']))
    if isfield(KSMPipt.(PanelLabel1).Struct,'selectedfile')
        file = KSMPipt.(PanelLabel1).Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = ['(Re) Load ',PanelLabel1];
            ErrDisp(err);
            return
        else
            Status2('busy',['Loading ',PanelLabel1],2);
            load(file);
            saveData.path = file;
            KSMPipt.([CallingLabel,'_Data']).([PanelLabel1,'_Data']) = saveData;
        end
    else
        err.flag = 1;
        err.msg = ['(Re) Load ',PanelLabel1];
        ErrDisp(err);
        return
    end
end
if LoadAll == 1 || not(isfield(KSMPipt.([CallingLabel,'_Data']),[PanelLabel2,'_Data']))
    if isfield(KSMPipt.(PanelLabel2).Struct,'selectedfile')
        file = KSMPipt.(PanelLabel2).Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = ['(Re) Load ',PanelLabel2];
            ErrDisp(err);
            return
        else
            Status2('busy',['Loading ',PanelLabel2],2);
            load(file);
            saveData.path = file;
            KSMPipt.([CallingLabel,'_Data']).([PanelLabel2,'_Data']) = saveData;
        end
    else
        err.flag = 1;
        err.msg = ['(Re) Load ',PanelLabel2];
        ErrDisp(err);
        return
    end
end

%---------------------------------------------
% Load Panel Input
%---------------------------------------------
KSMP.method = KSMPipt.Func;

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
ReturnData.('Kern_File_Data') = KSMPipt.([CallingLabel,'_Data']).('Kern_File_Data');
ReturnData.('InvFilt_File_Data') = KSMPipt.([CallingLabel,'_Data']).('InvFilt_File_Data');
KSMP.IFprms = KSMPipt.([CallingLabel,'_Data']).('InvFilt_File_Data').IFprms;
KSMP.KRNprms = KSMPipt.([CallingLabel,'_Data']).('Kern_File_Data').KRNprms;

Status2('done','',2);
Status2('done','',3);

