clear variables;
close all;
clc;
pkg load signal;

% GAIN DE BANDE PASSANTE (par principe de bande lat�rale unique)
% MODULATION

%% Constantes
Fe = 96000;
Fp = 3000;
Fc = 3000;

%% Enregistrement (r�cup�ration des signaux)
%Option 1 : lecture de 2 fichiers audio enregistr�s
[s,Fe]=audioread('test1.wav'); %Pour eviter les enregistrements st�r�o
[s2,Fe]=audioread('test2.wav');  %Pour eviter les enregistrements st�r�o
s = (s(:,1))';
s2 = (s2(:,1))';
T=length(s)*1/Fe;
t=0:1/Fe:T-1/Fe; 

%Option 2 : Enregistrement de 2 messages de 3 secondes
%[nomfichier, s, t] = RecordModulation(Fe, 3);
%s = (s(:,1))'; %Pour eviter les enregistrements st�r�o
%[nomfichier, s2, t] = RecordModulation(Fe, 3);
%s2 = (s2(:,1))'; %Pour eviter les enregistrements st�r�o


%% Porteuses de signaux
cosinus = cos(2*pi*Fp*t);
sinus = sin(2*pi*Fp*t);
porteuse = cos(2*pi*Fp*t);

%% Transform�e de Hilbert (principe permettant de cr�er la bande lat�rale unique)
[s_filtre]=PasseBas(s,Fe,Fc);
y = hilbert(s_filtre);
TH_s_f = imag(y);
x = s_filtre.*cosinus - TH_s_f.*sinus; % Modulation BLU 

[s2_filtre]=PasseBas(s2,Fe,Fc);
y2 = hilbert(s2_filtre);  
TH_s2_f = imag(y2);
x2 = s2_filtre.*cosinus + TH_s2_f.*sinus; % Modulation BLU 

%% Signal final
s_transmi = x + x2;

%% Affichage modulation
[X,freq]=TransFourier(x,t);
[X2,freq]=TransFourier(x2,t);
[S_Transmi,freq]=TransFourier(s_transmi,t);
%Affichage du spectre des 2 signaux filtr�s et modul�s
figure(1);
hold on;
plot(freq, abs(X));
plot(freq, abs(X2));
title("spectre des 2 signaux filtr�s et modul�s");
xlabel('nu (Hz)');
legend('signal 1', 'signal 2');
%Affichage du spectre signal �mis filtr� et modul�
figure(2);
plot(freq, abs(S_Transmi));
title("spectre du signal �mis");
xlabel('nu (Hz)');


%% Enregistrement du signal filtr� sous le format wav (permet de tester en cas de probl�me)
audiowrite('audioEXPORTBLU.wav', s_transmi, Fe);

%% Lecture du signal modul� en boucle
while true
  sound(SignalOutput,Fe)
end