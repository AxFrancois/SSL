function y=filtel(x,fs)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% programme de filtrage d'un signal dans la bande téléphonique 
%
% y=filtrage(x,nue)
%
% variables d'entrée:
%   x : vecteur contenant le signal d'entrée
%   nue : fréquence d'échantillonnage du signal auquel le filtre est
%   destiné
%   
% Cette fonction crée un filtre dans la bande 300-3400 Hz
% à l'aide de la fonction POTSBAND extraite de la boite à outils VOICEBOX
%      Copyright (C) Mike Brookes 1998
%   VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
% Elle filtre le signal contenu dans le vecteur x
% Le signal filtré se trouve dans le vecteur y

% développé par N. Gache le 7/12/2012 pour les TP SP1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%POTSBAND Design filter for 300-3400 telephone bandwidth [B,A]=(FS)
%
%Input: FS=sample frequency in Hz
%
%Output: B/A is a discrete time bandpass filter with a passband gain of 1
%
%The filter meets the specifications of G.151 for any sample frequency
%and has a gain of -3dB at the passband edges.


%      Copyright (C) Mike Brookes 1998
%
%      Last modified Fri Apr  3 14:59:06 1998
%
%   VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You can obtain a copy of the GNU General Public License from
%   ftp://prep.ai.mit.edu/pub/gnu/COPYING-2.0 or by writing to
%   Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% postband
szp=[0.19892796195357i; -0.48623571568937+0.86535995266875i]; 
szp=[[0; -0.97247143137874] szp conj(szp)];
% s-plane zeros and poles of high pass 3'rd order chebychev2 filter with -3dB at w=1
zl=2./(1-szp*tan(300*pi/fs))-1;
al=real(poly(zl(2,:)));
bl=real(poly(zl(1,:)));
sw=[1;-1;1;-1];
bl=bl*(al*sw)/(bl*sw);
zh=2./(szp/tan(3400*pi/fs)-1)+1;
ah=real(poly(zh(2,:)));
bh=real(poly(zh(1,:)));
bh=bh*sum(ah)/sum(bh);
b=conv(bh,bl);
a=conv(ah,al);
y=filter(b,a,x);
