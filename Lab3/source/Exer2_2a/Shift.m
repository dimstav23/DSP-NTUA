function [Right_Shifted_Signal] = Shift(Signal, synt)
%time shift function
DFT_signal = fft(Signal);
%w1 = 1:length(DFTofSignIn);
w1 = linspace(0,2*pi,length(DFT_signal)); 
w = w1*48000; 
Hd = exp(-1i*w*synt);
Right_Shifted_Signal = ifft(DFT_signal .* Hd');