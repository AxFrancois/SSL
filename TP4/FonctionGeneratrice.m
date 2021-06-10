function [T,s] = FonctionGeneratrice(A, nu0, Phi0, D, Fe)
  
  %Création de T
  T = (0:D*Fe -1)/Fe;
  %Création de s
  s = A * sin(2*pi*nu0.* T +Phi0); % .*(T>=0 & T<D) 
endfunction
