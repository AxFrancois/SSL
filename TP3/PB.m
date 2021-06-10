function [y] = PB (x,Fs,Fc)
%
% [y] = PBRC (x,Fs,Fc) filters the signal x with a digital lowpass filter whose 
% cut-off frequency is specify in Fc.
% %
% Inputs
% - x     input signal 
% - Fs   : scalar indicating the sampling frequency (must be
%           identical to that of X)
% - Fc   : scalar defining the cut-off frequency (must be lower than Fs/2)%           
%
% Output
%
% - y     output signal 

% NG : november 2017

Wn=2*Fc/Fs;
N=5;
[B,A] = butter(N,Wn,'low');
y=filter(B,A,x);


