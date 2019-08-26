%exer 2.2
clear all;
[x,fs]= wavread('speech.wav') ;
load('pitch.mat');
sig=lpc_vocoder(x,48000,1440,960,pitch);
wavwrite (sig,48000,'synthesis') ;
