function [p] = peigne(T0,t) 

% [p] = peigne(T0,t) 
% Genere un peigne de Dirac de periode T0 en fonction du vecteur temps 't'.
% Attention: T0 est arrondi au multiple entier de la periode
% d'echantillonnage de t
%
% PG : 2017

dt = t(2)-t(1) ; 
if rem(T0,dt) ~= 0 % cas ou T0 ~= multiple entier de dt
    T0 = round(T0/dt)*dt ;
    warning(['La periode T0 a ete arrondie a T0 = ',num2str(T0)])
end
N = length(t) ;
D = (max(t)-min(t) + dt)/2 ;
M = floor(D/T0) ;
p = zeros(1,N) ;
IndiceOne = ([-M:M]*T0)./dt + floor(N/2 + 1);
IndiceOne = IndiceOne(IndiceOne>0 & IndiceOne<=N) ;
p(IndiceOne) = ones(size(IndiceOne)) ;
