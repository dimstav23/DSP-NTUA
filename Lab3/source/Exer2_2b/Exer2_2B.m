clc;
clear;
s = wavread('source.wav');
s_central = wavread('sensor_3.wav');
L=length(s);
%tha kanw parathyra twn 30ms me overlap 50%, dhladh para8yra 1440 deigmatwn
%8a xreiastw 119 para8yra
s(171272:171360)=0;
s_central(171272:171360)=0; %zero-padding gia na exw akrivws 119 para8yra
%vriskw to u^2 apo to 1o para8yro pou periexei mono 8oryvo
noise=s(1441:2880);
Ps_noise = pwelch(noise,480,240,1440,48000,'twosided'); %para8yra twn 10ms me epikalypsh 50%
%efarmozw beam-former gia na kanw meta monokanaliko IIR Wiener 
%sto shma pou prokyptei opws ekana kai se prohgoumenes askhseis
N = 7; %ka8orismos parametrwn
d = 0.08;
c = 340;
sum_sign = 0;
theta = pi/2;
for i=0:(N-1)
sensor = ['sensor_' num2str(i) '.wav']; %edw tou orizw poio sensor diavazw,apla kanw to i string gia na to vrei t matlab
sign = wavread(sensor);
shift_value = -(i-(N-1)/2)*d*cos(theta)/c;
Shifted = Shift(sign , shift_value); %efarmozw thn xronikh metatopish gia ka8e shma
sum_sign = sum_sign + Shifted; %a8roizw ta shmata apo tous sensors meta apo to katallhlo time shift
end
sum_sign = sum_sign/N;  %pairnw to m.o. twn shmatwn
real_signal = wavread('source.wav');
diff = real(sum_sign) - real_signal; %vriskw th diafora tou kanonikou shmatos apo to ypologismeno
%to real ( sum_sign) einai to shma pou 8a epe3ergastw
s=real(sum_sign);
%twra 8a para8yropoihsw kai 8a filtrarw to shma ayto kata wiener
%gia ka8e para8yro tou
w=hamming(1440);
%to s exei 171272 deigmata
%kanw 3ana zero-padding
s(171273:171360)=0;
index=1;
final(1:171360)=0;
final=final';
for (i=1:238)
    if (i~=238)
    windowed_frame=w.*s(index:index+1440-1);
    Ps_Windowed_Beam_Pattern = pwelch(windowed_frame,480,240,1440,48000,'twosided');
    Hw=1-(Ps_noise./Ps_Windowed_Beam_Pattern);
    DFT_W_Frame = fft(windowed_frame);
    DFT_Out = Hw.*DFT_W_Frame; %wiener filtrarisma
    Out = ifft(DFT_Out);
    final(index:index+1440-1)=final(index:index+1440-1)+Out;
    index=index+720;
    end

end


wavwrite(final, 48000,'real_mmse.wav');

figure;
real_sign= wavread('source.wav');
subplot(221);
plot(real_sign);
title('Katharo Shma Fwnhs');

subplot(222);
central_mic = wavread('sensor_3.wav');
plot(central_mic);
title('Thoryvwdes Shma sto Kentriko Mikrofwno');

%h eisodos tou wiener filtrou einai h e3odos s tou beamformer

subplot(223);
plot(s);
title('Eisodos tou Wiener Filtrou');

subplot(224);
plot(final);
title('Eksodos tou Wiener Filtrou');

figure;
spectrogram(real_sign,960,480);
title('Katharo Shma Fwnhs');

figure;
spectrogram(central_mic,960,480);
title('Thoryvwdes Shma sto Kentriko Mikrofwno');

figure;
spectrogram(s,960,480);
title('Eisodos tou Wiener Filtrou')

figure;
spectrogram (final,960,480);
title('Eksodos tou Wiener Filtrou');

SSNR_before_Wiener_Filter=SegmentalSNR(s,100) %epilegw 100 para8yra gia to shma mou,dhladh ka8e para8yro me diarkeia peripou 30ms
SSNR_after_Wiener_Filter=SegmentalSNR(final,100) %epilegw 100 para8yra gia to shma mou

sum_of_SSNRs=0;

for i=0:(N-1)
    sensor = ['sensor_' num2str(i) '.wav'];
    signal = wavread(sensor);
    sum_of_SSNRs=SegmentalSNR(signal,100)+sum_of_SSNRs; %eyresh SSNRs twn arxikwn shmatwn
end
sum_of_SSNRs=sum_of_SSNRs+SSNR_before_Wiener_Filter; %vazw kai to SSNR tou shmatos prin to Wiener filtro
meanSSNR=sum_of_SSNRs/8

