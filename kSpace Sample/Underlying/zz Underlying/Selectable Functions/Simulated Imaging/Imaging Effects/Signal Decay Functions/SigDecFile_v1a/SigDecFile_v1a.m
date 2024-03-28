%=========================================================
% 
%=========================================================

function [SCRPTipt,SIGDEC,err] = SigDecFile_v1a(SCRPTipt,SIGDECipt)

Status2('busy','Get Signal Decay Info',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

CallingLabel = SIGDECipt.Struct.labelstr;
%---------------------------------------------
% Tests
%---------------------------------------------
if not(isfield(SIGDECipt,[CallingLabel,'_Data']))
    if isfield(SIGDECipt.('SigDec_File').Struct,'selectedfile')
        file = SIGDECipt.('SigDec_File').Struct.selectedfile;
        if not(exist(file,'file'))
            err.flag = 1;
            err.msg = '(Re) Load SigDec_File';
            ErrDisp(err);
            return
        else
            SIGDECipt.([CallingLabel,'_Data']).('SigDec_File_Data').path = file;
        end
    else
        err.flag = 1;
        err.msg = '(Re) Load SigDec_File';
        ErrDisp(err);
        return
    end
end

%---------------------------------------------
% Return Panel Input
%---------------------------------------------
SIGDEC.method = SIGDECipt.Func;
SIGDEC.TE = str2double(SIGDECipt.('TE'));
SIGDEC.SigDec_File = SIGDECipt.([CallingLabel,'_Data']).('SigDec_File_Data').path;
SIGDEC.Data = SIGDECipt.([CallingLabel,'_Data']).('SigDec_File_Data').Data;

%-- test --
figure(100);
plot(fftshift(abs(fft(SIGDEC.Data.sig))));

Status2('done','',2);
Status2('done','',3);


