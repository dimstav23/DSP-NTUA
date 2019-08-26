function [s_lpc] = Quantized_Values_Voc(siglen,Fs,winlen,winovlp,Pitch_Check,G_Quantized,g_Quantized,nw)

% s       : speech signal
% Fs      : sampling Frequency
% pitch   : pitch values (Hz), random noise excitation where 0
% winlen  : length of analysis window
% winovlp : overlap between windows

% s_lpc   : reconstructed speech

% Digital Signal Processing, Lab2
% LPC vocoder
% CVSP implementation (April 2015)

%% Signal framming
% Window step
winstep = winlen - winovlp;   
% Construct a hamming window, the same length with analysis window
w=hamming(winlen);  
%Check overlap-add
ola(winlen,winstep,siglen)
% Initialize the voice reconstruction buffer with zeros 
s_lpc = zeros(1,siglen);
% Define a counter for the begining sample of the moving window 
count=1;
for i=1:nw             
    % Generate excitation signal u as a pulse train with T=1/f intervals or a white-noisy
    % signal both having the same length as the analysis window
    f = Pitch_Check(i)
    u = ugenerator(f,winlen,Fs);  
%     figure(1),plot(u)
%     pause
    % Reconstruct the i-frame
    sframe = filter(G_Quantized(i),g_Quantized(i,:),u);
    
    % Overlap - Add: Add the reconstructed frame into the reconstruction buffer 
    % by overlapping the i-1 segment by 2/3 of window size
    
    segstart = count;
    segend = min((segstart+winlen-1),siglen);
    seglen = segend - segstart + 1;
    
    s_lpc(segstart:segend) = s_lpc(segstart:segend) + sframe(1:seglen); 
    count = count + winstep;
    
end    

%% Amplitude Normalization of reconstructed speech
% Scale/Normalize the synthetic voice signal in [-1 1]
s_lpc = s_lpc/max(s_lpc); 

%% Plots
t = [0:(siglen-1)] / Fs;

figure(1);
plot(t ,s_lpc);grid on;
title('Reconstructed Voice with Quantized Parameters');
xlabel('Time (Seconds)');

figure(2)
% Spectogram usage: [S,F,T,P] = spectrogram(x,window,noverlap,nfft,fs)
[S,F,T,P] = spectrogram(s_lpc, hamming(winlen), winovlp, nextpow2(siglen), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight;
view(0,90);
title('Spectogram of Reconstructed Voice with Quantized Parameters');
xlabel('Time (Seconds)'); ylabel('Hz');
