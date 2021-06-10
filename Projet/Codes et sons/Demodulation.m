clear variables;
close all;
clc;
pkg load signal;

%DEMODULATION DU SIGNAL

%% Constantes
Fp=3000;
Fe=96000;
Fc=3000;

%% Récupération du signal et création d'un vecteur temps adapté
%Option 1 : Récupération à partir d'un fichier wav exporté par la partie modulation
[audio,Fe]=audioread('audioEXPORT.wav');
audio = audio(:,1)';  %Pour eviter les enregistrements stéréo
T=length(audio)*1/Fe;  
t=0:1/Fe:T-1/Fe; 


%Option 2 : Récupération par la prise jack 
%[nomfichier, audio, t] = RecordModulation(Fe, 6);
%audio = (audio(:,1))'; %Pour eviter les enregistrements stéréo

%% Porteuse (identique à  la porteuse de la modulation)
porteuse = sin(2*pi*Fp*t);

%% Démodulation du signal par multiplication avec la porteuse
%/!\ ici audio est le signal d'entrée, c'est à dire modulé
s_demod = audio .* porteuse;  %Signal démodulé
s_demod_filtre = PasseBas(s_demod, Fe, Fc);     %On filtre pour supprimer les résidus de démodulation
signal_sortie = s_demod_filtre * 2;

%% Lecture et enregistrement
soundsc(signal_sortie, Fe);
audiowrite('audioOUTPOUT.wav', signal_sortie, Fe);


%% Affichage
%Affichage du signal modulé d'entrée
figure(1);
plot(t, audio);
title("Signal modulé");

%Affichage du spectre du signal modulé d'entrée
figure(2); 
[spectre,nu]=TransFourier(audio, t);
plot(nu ,abs(spectre));
title("Spectre du signal modulé")

%Affichage du spectre du signal démodulé mais pas filtré
figure(3); 
[spectre2,nu]=TransFourier(s_demod, t);
plot(nu ,abs(spectre2));
title("Spectre du signal démodulé mais pas filtré")

%Affichage du signal modulé d'entrée et du signal démodulé de sortie
figure(4);
hold on;
plot(t, audio);
plot(t,signal_sortie, 'LineWidth', 1.2);
grid on;
title('Démodulation');
xlabel('t');
legend('signal modulé', 'signal démodulé et filtré');

%Affichage du spectre du signal démodulé et filtré
figure(5); 
[spectre3,nu]=TransFourier(signal_sortie, t);
plot(nu ,abs(spectre3));
title("Spectre du signal modulé et filtré")

