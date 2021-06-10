function [T,s] = FonctionGeneratrice(A, nu0, Phi0, D, Fe)
  
  %Cr�ation de T
  T = (0:D*Fe -1)/Fe;
  %Cr�ation de s
  s = A * sin(2*pi*nu0.* T +Phi0); % .*(T>=0 & T<D) 
endfunction
