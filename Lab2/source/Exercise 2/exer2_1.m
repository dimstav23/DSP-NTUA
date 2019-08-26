%8a xrhsimopoihsw ena mono frame to opoio epilegw au8aireta
clear all;
[x,Fs]= wavread ('speech.wav');
new =x(1001:2440);
[a1, G1, lpc_error1, speech_frame_est1]=lpc_analysis (new ,52);
[a2, G2, lpc_error2, speech_frame_est2]=lpc_analysis (new ,28);

figure;
subplot(1,2,1) ; 
plot(lpc_error1,'color','g');
title ('LPC error , p=52');
subplot (1,2,2);
plot(lpc_error2,'color','b');
title ('LPC error , p=28');

figure;
plot(lpc_error1,'color','g'); hold on; 
plot(lpc_error2,'color','b'); hold off;
title ('LPC error , p=52(green), p=28(blue)');

%fasmata gia p=52
lpc_sp= abs(fft(speech_frame_est1));
new_fasma=abs((fft(new)));
%koino diagramma
figure;
plot (20*log10(lpc_sp),'color', 'g') ;
hold on;
plot (20*log10(new_fasma), 'color', 'b') ;
hold off;
title ('20log10(|H(ejù)|)(green) , 20log10(|X(ejù)|)(blue)');


%fasma gia p=28
lpc_sp= abs(fft(speech_frame_est2));
new_fasma=abs((fft(new)));
%koino diagramma
figure;
plot (20*log10(lpc_sp),'color', 'g') ;
hold on;
plot (20*log10(new_fasma), 'color', 'b') ;
hold off;
title ('20log10(|H(ejù)|)(green) , 20log10(|X(ejù)|)(blue)');