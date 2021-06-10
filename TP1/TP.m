clear variables;
close all;
clc;

D=5;
N=2000;
t=linspace(-D,D,N+1);
t=t(1:end-1);

%p = [];
%for index = t;
%    if index <= 1 && index >= -1;
%        p = [p,1];
%    else;
%        p = [p,0];
%    end
%end

T=2;
p=t>-T/2 & t<T/2;
%plot(t,p)
%title('Porte')

[TransP,f] = TransFourier(p,t);
%subplot(1,2,1);
%plot(f, imag(TransP))
%title('Imag')
%subplot(1,2,2);
%plot(f, real(TransP))
%title('Réelle')

%subplot(4,4,4);
%plot(f, abs(TransP).*abs(TransP))
%title('Densité spectrale')


T=2;
t0 = 2;
p2=t>-T/2+t0 & t<T/2+t0;
%subplot(1,1,1)
%hold on
%plot(t,p2,'color',[1,0,0])
%plot(t,p,'color',[0,0,1])
%title('p(t) & p(t-t0)')

[TransP2,f] = TransFourier(p2,t);
%subplot(1,2,1);
%hold on;
%plot(f, imag(TransP2),'color',[1,0,0])
%plot(f, imag(TransP),'color',[0,0,1])
%title('Imag')
%subplot(1,2,2);
%hold on;
%plot(f, real(TransP2),'color',[1,0,0])
%plot(f, real(TransP),'color',[0,0,1])
%title('Réelle')


T=2;
a=2;
p3=t>-T/(2*a) & t<T/(2*a);
%subplot(1,2,1);
%hold on
%plot(t,p3,'color',[0,1,0])
%plot(t,p,'color',[0,0,1])
%title('pa(t) (vert)')

[TransP3,f] = TransFourier(p3,t);
%subplot(1,2,2);
hold on
%plot(f, abs(TransP).*abs(TransP),'color',[0,1,0])
%plot(f, abs(TransP3).*abs(TransP3),'color',[0,0,1])
%title('Densité spectrale pa(t) (vert)')


A = 3;
f0 = 20;
s=[];
for i = linspace(1,N,N);
  s = [s,p(1,i) * A*cos(2*pi*f0*t(1,i))];
endfor

%subplot(4,4,13)
plot(t,s)
title('S(t)')

[TransS,f] = TransFourier(s,t);
subplot(4,4,14);
hold on
plot(f, imag(TransS),'color',[1,0,0])
plot(f, real(TransS),'color',[0,0,1])
title('Imag : rouge, Réelle : bleu')

dt = 2*D/N;
df = f(2)-f(1)
EnergieSt = sum((abs(s).^2).*dt)
EnergieSf = sum((abs(TransS).^2).*df)
