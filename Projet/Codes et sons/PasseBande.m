function [s]=PasseBande(z,Fe,FcLow,FcHigh)
 
% [s]=PasseBas(z,Fe,FcLow,FcHigh)
% Filtrage passe-bande du signal temporel z dans la bande 
% [-FcHigh,FcLow] U [FcLow,FcHigh]
% Inputs
% z  : vecteur des echantillons temporels du signal a filtrer
% Fe : frequence d'echantillonnage de z
% FcLow  : frequence de coupure Basse a -3dB du filtre passe-bande
% FcHigh : frequence de coupure Haute a -3dB du filtre passe-bande
% Outputs:
% s  : vecteur des echantillons temporels du signal filtre

% PG : 2019

WcLow = 2*FcLow/Fe ;
WcHigh = 2*FcHigh/Fe ;
ordre = 9;
[B,A] = butter(ordre,[WcLow, WcHigh]) ;
figure(2)
freqz(B,A)
s = filtfilt(B,A,z) ;
 
 