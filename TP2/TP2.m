pkg load signal
clear variables;
close all;
clc;

A = 1;
f0 = 7;
Fs = 1000;
T0 = 1/f0;
T = 5*T0;
D=3*T;
inter = round(D*Fs);
t = linspace(0,D,round(D*Fs) + 1 );
t=t(1:end-1);

p=t>0 & t<T;
z=A*cos(2*pi*f0*t);
x= p.*z;

tau0 = 1.5 * T;
ptau=t>tau0 & t<(T+tau0);
z=A*cos(2*pi*f0*(t-tau0));
y=ptau .* z;


%hold on
%plot(t,x)
%plot(t,y)
%xlabel('t (s)')
%ylabel('x(t) bleu, y(t) orange')
%title('x(t) et y(t)');

[Ryx,tPrime] = xcorr(y,x);
ts = t(2)-t(1);
Gammayx = Ryx.*ts;
tau = tPrime.*ts;
%plot(tau,Gammayx)
%xlabel('tau (s)')
%ylabel('Gammayx')
%title('Gammayx en fonction de tau');

p2T=tau>(-T+tau0) & tau<(T+tau0);
GammaxTheo = A^2 * T/2 * cos(2*pi*f0*(tau-tau0)).*(1-abs(tau-tau0)/T) .*p2T;
mesureAmpli = A^2 * T/2*(1-(tau-tau0)/T);
hold on
plot(tau,Gammayx)
plot(tau,GammaxTheo)
plot(tau,mesureAmpli)
plot(t,x)

sigma = 10;
z = y + sigma*randn(size(y));
%hold on
%plot(t,x)
%plot(t,z)
[Rzx,tPrime] = xcorr(z,x);
ts = t(2)-t(1);
Gammazx = Rzx.*ts;
tau = tPrime.*ts;
%hold on
%plot(tau,Gammazx)
%plot(tau,Gammayx)

Deltaf = 0.13*f0;
z=cos(2*pi*(f0+Deltaf)*(t-tau0));
w=ptau .* z;
%hold on
%plot(t,w)
%plot(t,y)
[Rwx,tPrime] = xcorr(w,x);
ts = t(2)-t(1);
Gammawx = Rwx.*ts;
tau = tPrime.*ts;
%hold on
%plot(tau,Gammawx)
%plot(tau,Gammayx) % (1.29491-1.0714)/1.0714 = 21% : c'est pas ouf du tout
%à T = 4*T0 c'est mieux : 4% d'erreur relative ((0.8222-0.85714)/0.85714)

[TransGammawx,f] = TransFourier(Gammawx,tau);
%plot(f, abs(TransGammawx).^2)
%axis([-20 20 0 inf])



A = 1;
f0 = 7;
Fs = 1000;
T0 = 1/f0;
T = 4*T0;
D=3*T;
inter = round(D*Fs);
t = linspace(0,D,round(D*Fs) + 1 );
t=t(1:end-1);

p=t>0 & t<T;
z=A*cos(2*pi*f0*t);
x= p.*z;

tau0 = 1.5 * T;
ptau=t>tau0 & t<(T+tau0);
z=A*cos(2*pi*f0*(t-tau0));
y=ptau .* z;

%{
%hold on
%plot(t,x)
%plot(t,y)
%xlabel('t (s)')
%ylabel('x(t) bleu, y(t) orange')
%title('x(t) et y(t)');

[Ryx,tPrime] = xcorr(y,x);
ts = t(2)-t(1);
Gammayx = Ryx.*ts;
tau = tPrime.*ts;
%plot(tau,Gammayx)
%xlabel('tau (s)')
%ylabel('Gammayx')
%title('Gammayx en fonction de tau');

p2T=tau>(-T+tau0) & tau<(T+tau0);
GammaxTheo = A^2 * T/2 * cos(2*pi*f0*(tau-tau0)).*(1-abs(tau-tau0)/T) .*p2T;
mesureAmpli = A^2 * T/2*(1-(tau-tau0)/T);
%hold on
%plot(tau,Gammayx)
%plot(tau,GammaxTheo)
%plot(tau,mesureAmpli)
%plot(t,x)

sigma = 10;
z = y + sigma*randn(size(y));
%hold on
%plot(t,x)
%plot(t,z)
[Rzx,tPrime] = xcorr(z,x);
ts = t(2)-t(1);
Gammazx = Rzx.*ts;
tau = tPrime.*ts;
%hold on
%plot(tau,Gammazx)
%plot(tau,Gammayx)

Deltaf = 0.13*f0;
z=cos(2*pi*(f0+Deltaf)*(t-tau0));
w=ptau .* z;
%hold on
%plot(t,w)
%plot(t,y)
[Rwx,tPrime] = xcorr(w,x);
ts = t(2)-t(1);
Gammawx = Rwx.*ts;
tau = tPrime.*ts;

%plot(tau,Gammawx)
%plot(tau,Gammayx) % (1.29491-1.0714)/1.0714 = 21% : c'est pas ouf du tout
%à T = 4*T0 c'est mieux : 4% d'erreur relative ((0.8222-0.85714)/0.85714)

[TransGammawx,f] = TransFourier(Gammawx,tau);
plot(f, abs(TransGammawx).^2)
axis([-20 20 0 inf])
title('Densité interspectrable d"énergie Gammaw,x(f)')
legend('T = 5To', 'T = 4T0')
}%