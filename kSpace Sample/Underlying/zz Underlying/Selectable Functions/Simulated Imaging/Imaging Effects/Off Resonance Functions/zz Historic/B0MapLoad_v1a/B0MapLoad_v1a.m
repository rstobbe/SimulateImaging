%===========================================
% (v1a)
%     
%===========================================

function [SCRPTipt,B0MAP,err] = B0MapLoad_v1a(SCRPTipt,B0MAPipt)

Status2('done','B0Map Input',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

B0MAP = struct();
CallingLabel = B0MAPipt.Struct.labelstr;
%---------------------------------------------
% Tests
%---------------------------------------------
LoadAll = 0;
if not(isfield(B0MAPipt,[CallingLabel,'_Data']))
    LoadAll = 1;
end
if LoadAll == 1 || not(isfield(B0MAPipt.([CallingLabel,'_Data']),'B0Map_File_Data'))
    if isfield(B0MAPipt.('B0Map_File').Struct,'selectedfile')
        file = B0MAPipt.('B0Map_File').Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = '(Re) Load B0Map_File';
            ErrDisp(err);
            return
        else
            load(file);
            saveData.path = file;
            saveData.B0Map = B0Map;
            B0MAPipt.([CallingLabel,'_Data']).('B0Map_File_Data') = saveData;
        end
    else
        err.flag = 1;
        err.msg = '(Re) Load B0Map_File';
        ErrDisp(err);
        return
    end
end

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
B0MAP.method = B0MAPipt.Func;
B0MAP.map = B0MAPipt.([CallingLabel,'_Data']).('B0Map_File_Data').B0MAP.Im;

Status2('done','',2);
Status2('done','',3);

