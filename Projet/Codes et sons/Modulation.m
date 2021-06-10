clear variables;
close all;
clc;
pkg load signal;

%MODULATION DU SIGNAL

%% Constantes
Fp=3000;
Fe=96000;
Fc=3000;


%% Récupération du fichier audio

%Option 1 : lecture d'un fichier audio enregistré
%[audio,Fe]=audioread('audio.wav');
%audio = audio(:,1);  %Pour eviter les enregistrements stéréo
%T=length(audio)*1/Fe;  
%t=0:1/Fe:T-1/Fe; 


%Option 2 : Enregistrement d'un message de 3 secondes
[nomfichier, audio, t] = RecordModulation(Fe, 3);
audio = (audio(:,1))'; %Pour eviter les enregistrements stéréo

%% Création de la porteuse
porteuse=sin(2*pi*Fp*t);

%Affichage du signal audio
figure(1)
plot(t,audio)
title("Signal original");
xlabel('t');

%% Suppression des fréquences trop hautes
[Signalfiltre]=PasseBas(audio,Fe,Fc);
%Affichage du signal filtré par le passe bas
figure(2)
plot(t,Signalfiltre)
title("Signal filtré");
xlabel('t');
%Affichage du spectre signal filtré par le passe bas
figure(3)
[spectreSignalfiltre,nu]=TransFourier(Signalfiltre, t);
plot(nu,spectreSignalfiltre)
title("spectre du signal filtré");
xlabel('nu (Hz)');

%% Modulation du signal par multiplication avec la porteuse
SignalOutput = Signalfiltre'.*porteuse;
%Affichage du signal filtré et modulé
figure(4)
plot(t,SignalOutput)
title("Signal filtré et modulé");
xlabel('t');
%Affichage du spectre signal filtré et modulé
figure(5)
[spectreSignalOutput,nu]=TransFourier(SignalOutput, t);
plot(nu,spectreSignalOutput)
title("spectre du signal filtré et modulé");
xlabel('nu (Hz)');


%% Enregistrement du signal filtré sous le format wav (permet de tester en cas de problème)
audiowrite('audioEXPORT.wav', SignalOutput, Fe);


%% Lecture du signal modulé en boucle
while true
  sound(SignalOutput,Fe)
end