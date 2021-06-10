function [S,f] = TransFourier2(s,t,fmax)

% [S,f] = TransFourier2(s,t,fmax)
%
% Version 2.0 de TransFourier.m (attention ne marche pas avec TransFourierInv.m): 
% Transformee de Fourier d'un signal s calculee sur l'intervalle
% [-fmax,fmax] ou fmax peut etre superieur a Fe/2
% Input: 
% - s: vecteur de taille N contenant les N echantillons s[n] du signal a
% analyser
% - t: vecteur de taille N contenant les instants d'echantillonnage de s.
% s[n] = s(t[n]).
% Outputs:
% - S : vecteur de taille N contenant les coeffeciens de la transformee de
% Fourier du signal s
% - f : vecteur de taille N contenant les frequences correspondant aux
% coefficients de S : S[n] = S(f[n])

% PG: 2017

s = s(:)' ;
N = length(s) ;

switch nargin
    case 1
        t  = 1:N ; 
end

if N ~= length(t)
    error('Les vecteurs "s" et "t" doivent etre de meme longueur')
end
if std(diff(t)) > 1000*eps
    error('Le vecteur ''t'' doit etre lineairement croissant et a pas constant')
end

dt = t(2)-t(1) ; Fe = 1/dt ;
sshift = [s(t>=0) s(t<0)] ;

M = N ;
S = fft(sshift,M) ; 
S = fftshift(S) ;
S = S.*dt ;
f = linspace(-Fe/2,Fe/2,M+1) ; 
f = f(1:M) ;

if exist('fmax')
    f = -fmax:Fe/M:fmax-Fe/M ;
    f2 = mod(f+Fe/2,Fe);
    S2 = S(round(f2./(Fe/M)+1)) ;
    S = S2 ;
end

