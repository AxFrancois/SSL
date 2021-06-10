clear variables;
close all;
clc;
pkg load signal;

% GAIN DE BANDE PASSANTE (par principe de bande latérale unique)
% DEMODULATION

%% Constantes
Fe = 96000;
Fp = 3000;
Fc = 3000;

%% Recupération du signal
%Option 1 : lecture d'un fichiers audio enregistrés modulé en BLU
[s_transmi,Fe]=audioread('audioEXPORTBLU.wav');
s_transmi = s_transmi(:,1)';  %Pour eviter les enregistrements stéréo
T=length(s_transmi)*1/Fe;  
t=0:1/Fe:T-1/Fe; 


%Option 2 : Récupération par la prise jack 
%[nomfichier, s_transmi, t] = RecordModulation(Fe, 6);
%s_transmi = (s_transmi(:,1))'; %Pour eviter les enregistrements stéréo

%% Porteuses de signaux
cosinus = cos(2*pi*Fp*t);
sinus = sin(2*pi*Fp*t);
porteuse = cos(2*pi*Fp*t);


%Nous n'arrivons pas à filtrer correctement le signal pour isoler les signaux 1 et 2
%Voici les 2 codes théorique puis les codes qui fonctionnent
%{
s_transmi_filtre1=PasseBande(s_transmi,Fe,0,Fc);
signal_demodule_1 = s_transmi_filtre1 .* porteuse * 2;
s_demod_filtre1 = PasseBas(signal_demodule_1, Fe, Fc);

s_transmi_filtre2=PasseBande(s_transmi,Fe,Fc,2*Fc);
signal_demodule_2 = s_transmi_filtre2 .* porteuse * 2;
s_demod_filtre2 = PasseBas(signal_demodule_2, Fe, Fc);
%}


signal_demodule_2 = s_transmi .* porteuse * 2;
signal_demodule_1 = s_transmi .* porteuse * 2;

%% Lecture et enregistrement
soundsc(signal_demodule_2, Fe);
audiowrite('audioOUTPOUTBLU1.wav', signal_demodule_2, Fe);
soundsc(signal_demodule_1, Fe);
audiowrite('audioOUTPOUTBLU2.wav', signal_demodule_1, Fe);

%% Affichage 
[S_Dem_1,freq]=TransFourier(signal_demodule_2,t);
[S_Dem_2,freq2]=TransFourier(signal_demodule_1,t);
%Spectre de chaque signal
figure(1);
subplot(1,2,1);
plot(freq, abs(S_Dem_1));
subplot(1,2,2);
plot(freq2, abs(S_Dem_2));
