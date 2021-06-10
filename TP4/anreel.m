% analyse de signaux reels : anreel.m
% 
% ce programme permet d'effectuer l'analyse spectrale
% de 6 signaux réels
% en choisissant leur cadence d'échantillonnage
%

% nicole le 13/12/2016
%
% choix du signal à traiter
%
nom1='Cri sonar de chauve-souris ';
nom2='Décollage d''avion';
nom3='Vibrations moteur';
nom4='Echos SONAR';
nom5='Parole : "éléphant"';
nom6='EEG';
chsig=1;
while chsig<7
  chsig=menu('Choix de signaux',nom1,nom2,nom3,nom4,nom5,nom6,'FIN');
  if chsig==1
     load cs2.mat
     nom=nom1;
  end;
  if chsig==2
     load avion.mat
     nom=nom2;
  end;
  if chsig==3
     load vib.mat
     nom=nom3;
  end;
  if chsig==4
     load coque.mat
     nom=nom4;
  end;
  if chsig==5
     load elephant.mat
     nom=nom5;
  end;
  if chsig==6
     load EEG1.mat
     nom=nom6;
  end;
    if chsig<7
     figure(1)
     clf
     duree=length(signal)/fe;
     if duree>1
         t=(0:length(signal)-1)/fe;
         plot(t,signal)
         title(nom),xlabel('secondes')
     else 
         t=(0:length(signal)-1)*1000/fe;
         plot(t,signal)
         title(nom),xlabel('millisecondes')
     end
     set(gca,'XLim',[0 t(length(t))],'YLim',[1.1*min(signal) 1.1*max(signal)])
     %pause
     chech=1;
     while chech<7
     if fe>5e6 % coque
         chech=menu('Frequence d''echantillonnage',[num2str(fe/1000000),' MHz'],...
		[num2str(fe/2000000),' MHz'],[num2str(fe/4000000),' MHz'],...
		[num2str(fe/8000000),' MHz'],[num2str(fe/16000),' kHz'],...
		[num2str(fe/32000),' kHz'],'AUTRE SIGNAL');
     end
	 if (fe<5e6)& (fe>1e6) % CS
         chech=menu('Frequence d''echantillonnage',[num2str(fe/1000000),' MHz'],...
		[num2str(fe/2000000),' MHz'],[num2str(fe/4000),' kHz'],...
		[num2str(fe/8000),' kHz'],[num2str(fe/16000),' kHz'],...
		[num2str(fe/32000),' kHz'],'AUTRE SIGNAL');
     end
     if (fe<=1e6)& (fe>1e4) % parole
         chech=menu('Frequence d''echantillonnage',[num2str(fe/1000),' kHz'],...
		[num2str(fe/2000),' kHz'],[num2str(fe/4000),' kHz'],...
		[num2str(fe/8000),' kHz'],[num2str(fe/16000),' kHz'],...
		[num2str(fe/32),' Hz'],'AUTRE SIGNAL');
     end
     if (fe==1e4) % avion
         chech=menu('Frequence d''echantillonnage',[num2str(fe/1000),' kHz'],...
		[num2str(fe/2000),' kHz'],[num2str(fe/4000),' kHz'],...
		[num2str(fe/8),' Hz'],[num2str(fe/16),' Hz'],...
		[num2str(fe/32),' Hz'],'AUTRE SIGNAL');
     end
     if (fe<=1e3) % EEG
         chech=menu('Frequence d''echantillonnage',[num2str(fe),' Hz'],...
		[num2str(fe/2),' Hz'],[num2str(fe/4),' Hz'],...
		[num2str(fe/8),' Hz'],[num2str(fe/16),' Hz'],...
		[num2str(fe/32),' Hz'],'AUTRE SIGNAL');
     end
 	 if chech==1
        sig=signal;
        fesech=fe;
        end;
     if chech==2
        sig=signal(1:2:length(signal));
        fesech=fe/2;
        end;
     if chech==3
        sig=signal(1:4:length(signal));
        fesech=fe/4;
        end;
        if chech==4
        sig=signal(1:8:length(signal));
        fesech=fe/8;
        end;
        if chech==5
        sig=signal(1:16:length(signal));
        fesech=fe/16;
        end;
        if chech==6
        sig=signal(1:32:length(signal));
        fesech=fe/32;
        end;
        %chech
	if chech<7
	% calcul des spectres
        r=nextpow2(length(sig));
        nfft=2*2^r;
		z=abs(fft(sig,nfft));
		sp=z(1:nfft/2);clear z
		sp=sp.*sp;
		nu=(0:(nfft/2)-1)*fesech/nfft;
		if fesech>2000
			nu=nu/1000;
		end;
		figure(2)
		clf
		subplot(2,1,1),plot(nu,sp)
        set(gca,'XLim',[0 nu(length(nu))],'YLim',[0 1.1*max(sp)])
		title(['spectre de ',nom,' nue = ',num2str(fesech/1000),' kHz en LINEAIRE'])
		if fesech>2000
			xlabel('kHz')
		else
			xlabel('Hz')
		end;
		subplot(2,1,2),plot(nu,10*log10(sp/max(sp)))
		set(gca,'XLim',[0 nu(length(nu))],'YLim',[-25 2])
		title(['spectre de ',nom,' nue = ',num2str(fesech/1000),' kHz en dB'])
		if fesech>2000
			xlabel('kHz')
		else
			xlabel('Hz')
		end;
		end; %if chech<7
     end;%while chech<7
   end;%if chsig<8
end; %while chsig<8
% close all, clear all


