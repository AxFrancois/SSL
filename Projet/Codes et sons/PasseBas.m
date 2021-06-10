
function [s]=PasseBas(z,Fe,Fc)
 
% [s]=PasseBas(z,Fe,Fc)
% Filtrage passe-bas du signal temporel z.
% Inputs
% z  : vecteur des echantillons temporels du signal a filtrer
% Fe : frequence d'echantillonnage de z
% Fc : frequence de coupure a -3dB du filtre passe-bas
% Outputs:
% s  : vecteur des echantillons temporels du signal filtre

% PG : 2017

Wc = 2*Fc/Fe ;
ordre = 9 ;
[B,A] = butter(ordre,Wc) ;
s = filtfilt(B,A,z) ;
 
 
 
 
 
