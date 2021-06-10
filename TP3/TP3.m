clear variables;
close all;
clc;
pkg load signal


[xa,Fea]= audioread('aaa.wav');
L = length(xa);
t1 = (0:L-1)/Fea;
%subplot(2,4,1)
%plot(t1,xa)

[xch,Fech]= audioread('chhh.wav');
L = length(xch);
t2 = (0:L-1)/Fech;
%subplot(2,4,5)
%plot(t2,xch)

[Transaaa,faaa] = TransFourier(xa,t1);
[Transchhh,fchhh] = TransFourier(xch,t2);

%subplot(2,4,2)
plot(faaa,abs(Transaaa).^2)
%title('densité spectrale d’énergie aaa');
%subplot(2,4,6)
%plot(fchhh,abs(Transchhh).^2)
%title('densité spectrale d’énergie chhh');
%les harmoniques de la consonnes sont beaucoup plus haute fréquence que celles de la voyelle

sfiltrea=PB(xa,Fea,260);
%subplot(2,4,3)
%plot(t1,sfiltrea)
[Transfiltreaaa,ffiltreaaa] = TransFourier(sfiltrea,t1);
%subplot(2,4,4)
%plot(ffiltreaaa./Fea,abs(Transfiltreaaa).^2)

sfiltrech=PB(xch,Fech,3000);
%subplot(2,4,7)
%plot(t2,sfiltrech)
[Transfiltrech,ffiltrech] = TransFourier(sfiltrech,t2);
%subplot(2,4,8)
%plot(ffiltrech./Fech,abs(Transfiltrech).^2)

%{
L = 100000;
f3 = (-L:L-1);
NbValeurs = length(f3);
porte=f3>-10000 & f3<10000;
%plot(f3, porte)
[PorteTemp,t3] = TransFourierInv(porte,f3);
%plot(t3, real(PorteTemp))
sfiltreporte=PB(PorteTemp,NbValeurs,1000);
%plot(t3, sfiltreporte)
[Transfiltreporte,ffiltreporte] = TransFourier(sfiltreporte,t3);
plot(ffiltreporte, Transfiltreporte)
%}

fcx = 500;
fcy = 3000;
dirac1 = zeros(1,length(t1));
dirac1(1) = 1;
dirf1 = PB(dirac1, Fea, fcx);

dirac2 = zeros(1,length(t2));
dirac2(1) = 1;
dirf2 = PB(dirac2, Fech, fcy);

%subplot(1,2,1);
%plot(t1,dirf1);

%subplot(1,2,2);
%plot(t2,dirf2);

%aaa 
%{
[Transfdirf1,ffiltrech] = TransFourier(dirf1,t1);
BP = (max(20*log10(abs(Transfdirf1))-3))*ones(1,length(ffiltrech));
subplot(1,2,1);
hold on
plot(ffiltrech,20*log10(abs(Transfdirf1)));
plot(ffiltrech,BP)
subplot(1,2,2);
plot(ffiltrech,atan2(imag(Transfdirf1),real(Transfdirf1)));
%}
%2.2
aaafiltre=PB(xa,Fea,fcx);
chhhfiltre=PB(xch,Fech,fcy);

[Transfaaafiltre,faaafiltre] = TransFourier(aaafiltre,t1);
[Transfchhhfiltre,fchhhfiltre] = TransFourier(chhhfiltre,t2);
%subplot(1,2,1);
%hold on
%plot(faaa,abs(Transaaa).^2)
%plot(faaafiltre,abs(Transfaaafiltre).^2);
%title('densité spectrale d’énergie aaa');
%legend('signal non filtré','signal filtré')
%subplot(1,2,2);
%hold on
%plot(fchhh,abs(Transchhh).^2)
%plot(fchhhfiltre,abs(Transfchhhfiltre).^2);
%legend('signal non filtré','signal filtré')
%title('densité spectrale d’énergie chhh');
%{
hold on
plot(t1,xa);
plot(t1,aaafiltre);
title('signal temporel aaa');
legend('signal non filtré','signal filtré')
%}
%{
hold on
plot(t2,xch);
plot(t2,chhhfiltre);
title('signal temporel chhh');
legend('signal non filtré','signal filtré')
%}

%3.1


[xphrase,Fphrase]=audioread('phrase1.wav');
L = length(xphrase);
t3 = (0:L-1)/Fphrase;
[Transfphrase,fphrase] = TransFourier(xphrase,t3);
xphrasefiltre = filtel(xphrase,Fphrase);
[Transfphrasefiltre,fphrasefiltre] = TransFourier(xphrasefiltre,t3);
%{
dirac3 = zeros(1,length(t3));
dirac3(1) = 1;
RepImpulFiltel=filtel(dirac3,Fphrase);
tr5 = (max(RepImpulFiltel)*0.05)*ones(1,length(t3));
hold on
plot(t3,RepImpulFiltel)
plot(t3, tr5)
plot(t3, -tr5)
axis([-0.002 0.01 -0.11 0.16])
%}
%{
[Transfdirfiltel,fdirfiltel] = TransFourier(RepImpulFiltel,t3);
BP = (max(20*log10(abs(Transfdirfiltel))-3))*ones(1,length(fdirfiltel));
subplot(2,1,1);
hold on
plot(fdirfiltel,20*log10(abs(Transfdirfiltel)));
title('Gain de filtel');
plot(fdirfiltel,BP)
subplot(2,1,2);
plot(fdirfiltel,atan2(imag(Transfdirfiltel),real(Transfdirfiltel)));
title('Phase de filtel');
%}

%3.2
%{
hold on
plot(t3, xphrase)
plot(t3, xphrasefiltre)
title('signal temporel Phrase 1');
legend('signal non filtré','signal filtré')
xlabel('temps en seconde') 
%}
%{
%sound(xphrase,Fphrase)
%sound(xphrasefiltre,Fphrase)
hold on
plot(fphrase,abs(Transfphrase).^2)
plot(fphrasefiltre,abs(Transfphrasefiltre).^2)
axis([-1000 1000])
title('densité spectrale d’énergie phrase');
legend('signal non filtré','signal filtré')
%}
