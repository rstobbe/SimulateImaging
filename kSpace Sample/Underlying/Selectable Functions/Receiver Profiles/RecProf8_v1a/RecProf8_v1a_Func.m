%=========================================================
%
%=========================================================

function [RPROF,err] = RecProf8_v1a_Func(RPROF,INPUT)

Status2('busy','Generate Receiver Profiles',2);
Status2('done','',3);

err.flag = 0;
err.msg = '';

%---------------------------------------------
% Get Input
%---------------------------------------------
Ob = INPUT.Ob;
sz = length(Ob);        % assume cube
clear INPUT;

%---------------------------------------------
% Sensitivity Map
%---------------------------------------------
Prof = zeros(sz,sz,sz);
for n = 1:sz
    for m = 1:sz
        for p = 1:sz
            rad = sqrt((n-7)^2 + (m-7)^2 + (p-7)^2);
            Prof(n,m,p) = 1/(rad)^1.8;
            if Prof(n,m,p) > 1
                Prof(n,m,p) = 1;
            end
        end
    end
end
Prof0 = Prof/max(Prof(:));

%---------------------------------------------
% Profile FoV Definition
%---------------------------------------------
ProfFov = ones(sz,sz,sz);
%ProfFov = zeros(sz,sz,sz);
%for n = 1:sz
%    for m = 1:sz
%        for p = 1:sz
%            rad = sqrt((n-(sz+1)/2)^2 + (m-(sz+1)/2)^2 + (p-(sz+1)/2)^2);
%            if rad <= sz/2+3
%                ProfFov(n,m,p) = 1;
%            end
%        end
%    end
%end

%---------------------------------------------
% Scaled Images
%---------------------------------------------
mOb = zeros(sz,sz,sz,8);
Prof = zeros(sz,sz,sz,8);
mOb(:,:,:,1) = Ob.*Prof0;
Prof(:,:,:,1) = Prof0.*logical(ProfFov);
mOb(:,:,:,2) = Ob.*flipdim(Prof0,1);
Prof(:,:,:,2) = flipdim(Prof0,1).*logical(ProfFov);
mOb(:,:,:,3) = Ob.*flipdim(Prof0,2);
Prof(:,:,:,3) = flipdim(Prof0,2).*logical(ProfFov);
mOb(:,:,:,4) = Ob.*flipdim(flipdim(Prof0,1),2);
Prof(:,:,:,4) = flipdim(flipdim(Prof0,1),2).*logical(ProfFov);
mOb(:,:,:,5) = Ob.*flipdim(Prof0,3);
Prof(:,:,:,5) = flipdim(Prof0,3).*logical(ProfFov);
mOb(:,:,:,6) = Ob.*flipdim(flipdim(Prof0,1),3);
Prof(:,:,:,6) = flipdim(flipdim(Prof0,1),3).*logical(ProfFov);
mOb(:,:,:,7) = Ob.*flipdim(flipdim(Prof0,3),2);
Prof(:,:,:,7) = flipdim(flipdim(Prof0,3),2).*logical(ProfFov);
mOb(:,:,:,8) = Ob.*flipdim(flipdim(flipdim(Prof0,1),2),3);
Prof(:,:,:,8) = flipdim(flipdim(flipdim(Prof0,1),2),3).*logical(ProfFov);

mOb = mOb/max(mOb(:));
Prof = Prof/max(Prof(:));
for n = 1:8
    figure(1000+n);
    imshow(squeeze(mOb(:,:,40,n)),[0 1]);
    figure(2000+n);
    imshow(squeeze(Prof(:,:,40,n)),[0 1]);
end

%---------------------------------------------
% Return
%---------------------------------------------
RPROF.RcvrProf = Prof;
RPROF.mOb = mOb;

Status2('done','',2);
Status2('done','',3);


