%=========================================================
% 
%=========================================================

function [ITSTipt,Dat] = Sodium_T2(Dat,nproj,npro,dwell,tro,ITSTipt)

T2f = str2double(ITSTipt(strcmp('T2f',{ITSTipt.labelstr})).entrystr);
T2s = str2double(ITSTipt(strcmp('T2s',{ITSTipt.labelstr})).entrystr);
TE = str2double(ITSTipt(strcmp('TE',{ITSTipt.labelstr})).entrystr);

[MDat] = DatArr2Mat(Dat,nproj,npro);
t = meshgrid((TE:dwell:tro+TE),(1:nproj));
ExpDecay = (0.6*exp(-t/T2f)+0.4*exp(-t/T2s))/(0.6*exp(-TE/T2f) + 0.4*exp(-TE/T2s));
%figure; plot(ExpDecay(1,:))
MDat = MDat.*ExpDecay;
[Dat] = DatMat2Arr(MDat,nproj,npro);
