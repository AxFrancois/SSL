clear variables;
close all;
clc;
pkg load signal

%%1.1 
%1
D = 1;
Fe = 25;
t = (0:D*Fe)/Fe;

%2
%CF fonction

%3
%{
A = 10;
D = 25;
Phi0 = pi/4;
nu0 = 25/D; %On veux 25 périodes
Fe = 51;

[T,s] = FonctionGeneratrice(A, nu0, Phi0, D, Fe);

%subplot(1,2,1)
%stem(T,s)
%title('Courbe des points');
%subplot(1,2,2)
hold on
plot(T,s)
%plot(T,zeros(1,length(T)))
title('Courbe du signal lissé');


%4
%Pas besoin : on étudie le signal sur toute sa durée
%Matlab/Octave linéarise la fonction entre les points
%On doit choisir une fréquence Fe >> 2 * nu0 pour respecter largemednt théorème d’échantillonnage de Shannon. Ici on a pris 51 (>>5) et qui permet une bonne visibilité des echantillonnages
%L'amplitude est bien respectée
%La phase à l'origne est elle un peut perturbée par le présence de la porte qui met le premier point d'échantillonage à 0
%D est bien respecté
%On a bien 25 périodes
%}
%%1.2
%{
A = 1;
D = 1;
Phi0 = 0;
nu0 = 800; 
Fe = 800; %Changer ici 10000, 3000, 1200 et 600

[T,s] = FonctionGeneratrice(A, nu0, Phi0, D, Fe);
[TFs, Freq] = TransFourier(s,T);

subplot(1,2,1)
plot(T,s)
title('Courbe s(t)');
subplot(1,2,2)
plot(Freq, abs(TFs))
title('spectre S(f)');
axis([-Fe Fe 0 max(abs(TFs))+0.1])
%}


%%PAR CURIOSITE

A = 1;
D = 1;
Phi0 = 0;
nu0 = 800; 
pas = 5;
Gamme = pas:pas:2000;
retour = zeros(1,length(Gamme));
for i = Gamme
  Fe= i;
  [T,s] = FonctionGeneratrice(A, nu0, Phi0, D, Fe);
  [TFs, Freq] = TransFourier(s,T);
  [M,I] = max(abs(TFs));
  retour(i/pas) = abs(Freq(I));
end
stem(Gamme, retour)


