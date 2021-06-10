function [nomfic,Signal,t] = RecordModulation(Fe,T)

% [nomfic,Signal,t] = RecordModulation(Fe,T)
% Permet de proceder a l'enregistrement audio d'un message.
% Numerisation sur 16 bits en mode mono.
%
% Inputs:
%   Fe      : frequence d'echantillonnage (multiple de 8kHz et inferieure ou
%   egale a 96kHz)
%   T       : dur?e (en secondes) du message a enregistrer
%
% Outputs:
%   nomfic  : Nom (chaine de characteres) du fichier .wav dans lequel a ete
%   enregistre le message
%   Signal  : vecteur contenant les echantillons du message enregistre
%   t       : vecteur temporel correspondant au vecteur Signal

% Version Projet Modulation de la fonction 'enregistrer.m' standard
% PG 2017

switch nargin
    case 1
        T=5;  % Duree d'enregistrement.
end

bits=16;
Canaux=1;
sauve = 0 ;

while sauve == 0 ;
% Cree objet audiorecorder.
Obj_Rec=audiorecorder(Fe,bits,Canaux);

disp('------  Parlez !!!  ------')
recordblocking(Obj_Rec, T); % Enregistre durant un temps T.
disp('------  STOP !!!  ------');

% Joue l'enregistrement.
play(Obj_Rec);
% disp('appuyer sur la barre d''espace une fois l''ecoute terminee')
% pause;
Signal=getaudiodata(Obj_Rec);

N=length(Signal);
t=(0:N-1)/Fe;
figure(1);
t = t(:) ;  Signal = Signal(:) ;
plot(t,Signal);

sauve=input('Sauvegarde dans un fichier ? oui=1 non=0 : ');
if sauve==1
    nomfic=input('Nom du fichier (entre cotes):  ');
    nomficwav=[nomfic,'.wav'];
    audiowrite(nomficwav,Signal,Fe);
end
end