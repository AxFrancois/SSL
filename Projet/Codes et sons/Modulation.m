clear variables;
close all;
clc;
pkg load signal;

%MODULATION DU SIGNAL

%% Constantes
Fp=3000;
Fe=96000;
Fc=3000;


%% R�cup�ration du fichier audio

%Option 1 : lecture d'un fichier audio enregistr�
%[audio,Fe]=audioread('audio.wav');
%audio = audio(:,1);  %Pour eviter les enregistrements st�r�o
%T=length(audio)*1/Fe;  
%t=0:1/Fe:T-1/Fe; 


%Option 2 : Enregistrement d'un message de 3 secondes
[nomfichier, audio, t] = RecordModulation(Fe, 3);
audio = (audio(:,1))'; %Pour eviter les enregistrements st�r�o

%% Cr�ation de la porteuse
porteuse=sin(2*pi*Fp*t);

%Affichage du signal audio
figure(1)
plot(t,audio)
title("Signal original");
xlabel('t');

%% Suppression des fr�quences trop hautes
[Signalfiltre]=PasseBas(audio,Fe,Fc);
%Affichage du signal filtr� par le passe bas
figure(2)
plot(t,Signalfiltre)
title("Signal filtr�");
xlabel('t');
%Affichage du spectre signal filtr� par le passe bas
figure(3)
[spectreSignalfiltre,nu]=TransFourier(Signalfiltre, t);
plot(nu,spectreSignalfiltre)
title("spectre du signal filtr�");
xlabel('nu (Hz)');

%% Modulation du signal par multiplication avec la porteuse
SignalOutput = Signalfiltre'.*porteuse;
%Affichage du signal filtr� et modul�
figure(4)
plot(t,SignalOutput)
title("Signal filtr� et modul�");
xlabel('t');
%Affichage du spectre signal filtr� et modul�
figure(5)
[spectreSignalOutput,nu]=TransFourier(SignalOutput, t);
plot(nu,spectreSignalOutput)
title("spectre du signal filtr� et modul�");
xlabel('nu (Hz)');


%% Enregistrement du signal filtr� sous le format wav (permet de tester en cas de probl�me)
audiowrite('audioEXPORT.wav', SignalOutput, Fe);


%% Lecture du signal modul� en boucle
while true
  sound(SignalOutput,Fe)
end