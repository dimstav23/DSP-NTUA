function [s_lpc] = lpc_vocoder(s,Fs,winlen,winovlp,pitch)

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
  
siglen = length(s);

% Window step
winstep = winlen - winovlp;   

% Construct a hamming window, the same length with analysis window
w=hamming(winlen);      

%Check overlap-add
ola(winlen,winstep,siglen)

% Divide the speech signal into equal length frames and put the segments columnwise in a matrix
frames = buffer(s,winlen,winovlp); 
nw = size(frames,2);

%% LPC analysis and speech reconstruction

% Define the order of the linear predictor (Convert Hz to KHz for Fs) 
order = (Fs/1000)+4; 

% Initialize the voice reconstruction buffer with zeros 
s_lpc = zeros(1,siglen);

% Define a counter for the begining sample of the moving window 
count=1;

% Zero-Padding of pitch signal
pitch_zp = [pitch zeros(1,nw-length(pitch))];

for i=1:nw 
    
    % i is the window index. Ignore the first 3 signal frames to compensate for the np~=n inequality
    currentframe = frames(:,i); 
    
    % Smoothing with hamming doing sample-by-sample multipication 
    windowedframe = w.*currentframe;     
    
    % Estimate the LPC parameters(The same function as in section 1)
    [a,G] = lpc_analysis( windowedframe,order );
 
    % Generate excitation signal u as a pulse train with T=1/f intervals or a white-noisy
    % signal both having the same length as the analysis window
    f = pitch_zp(i);
    u = ugenerator(f,winlen,Fs);    

%     figure(1),plot(u)
%     pause
    % Reconstruct the i-frame
    sframe = filter(G,a,u);
    
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
t = [0:(length(s)-1)] / Fs;

figure(1)
plot(t,s);grid on;
title('Natural Voice');
xlabel('Time (Seconds)'); 

figure(2);
plot(t ,s_lpc, 'r' );grid on;
title('Reconstructed Voice');
xlabel('Time (Seconds)');


figure(3)
subplot(2,1,1);
% Spectogram usage: [S,F,T,P] = spectrogram(x,window,noverlap,nfft,fs)
[S,F,T,P] = spectrogram(s, w, winovlp, nextpow2(siglen), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
title('Spectogram of Natural Voice');

subplot(2,1,2);
[S,F,T,P] = spectrogram(s_lpc, w, winovlp, nextpow2(siglen), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
title('Spectogram of Reconstructed Voice');
xlabel('Time (Seconds)'); ylabel('Hz');

end


