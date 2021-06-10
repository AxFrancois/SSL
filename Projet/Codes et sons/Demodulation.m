clear variables;
close all;
clc;
pkg load signal;

%DEMODULATION DU SIGNAL

%% Constantes
Fp=3000;
Fe=96000;
Fc=3000;

%% R�cup�ration du signal et cr�ation d'un vecteur temps adapt�
%Option 1 : R�cup�ration � partir d'un fichier wav export� par la partie modulation
[audio,Fe]=audioread('audioEXPORT.wav');
audio = audio(:,1)';  %Pour eviter les enregistrements st�r�o
T=length(audio)*1/Fe;  
t=0:1/Fe:T-1/Fe; 


%Option 2 : R�cup�ration par la prise jack 
%[nomfichier, audio, t] = RecordModulation(Fe, 6);
%audio = (audio(:,1))'; %Pour eviter les enregistrements st�r�o

%% Porteuse (identique � la porteuse de la modulation)
porteuse = sin(2*pi*Fp*t);

%% D�modulation du signal par multiplication avec la porteuse
%/!\ ici audio est le signal d'entr�e, c'est � dire modul�
s_demod = audio .* porteuse;  %Signal d�modul�
s_demod_filtre = PasseBas(s_demod, Fe, Fc);     %On filtre pour supprimer les r�sidus de d�modulation
signal_sortie = s_demod_filtre * 2;

%% Lecture et enregistrement
soundsc(signal_sortie, Fe);
audiowrite('audioOUTPOUT.wav', signal_sortie, Fe);


%% Affichage
%Affichage du signal modul� d'entr�e
figure(1);
plot(t, audio);
title("Signal modul�");

%Affichage du spectre du signal modul� d'entr�e
figure(2); 
[spectre,nu]=TransFourier(audio, t);
plot(nu ,abs(spectre));
title("Spectre du signal modul�")

%Affichage du spectre du signal d�modul� mais pas filtr�
figure(3); 
[spectre2,nu]=TransFourier(s_demod, t);
plot(nu ,abs(spectre2));
title("Spectre du signal d�modul� mais pas filtr�")

%Affichage du signal modul� d'entr�e et du signal d�modul� de sortie
figure(4);
hold on;
plot(t, audio);
plot(t,signal_sortie, 'LineWidth', 1.2);
grid on;
title('D�modulation');
xlabel('t');
legend('signal modul�', 'signal d�modul� et filtr�');

%Affichage du spectre du signal d�modul� et filtr�
figure(5); 
[spectre3,nu]=TransFourier(signal_sortie, t);
plot(nu ,abs(spectre3));
title("Spectre du signal modul� et filtr�")

