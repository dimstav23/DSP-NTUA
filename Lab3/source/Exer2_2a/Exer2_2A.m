%% 2.2 A erwthma (a)
clear all;
close all;
clc;
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
wavwrite(real(sum_sign), 48000,'real_ds.wav'); %eggrafh tou shmatos
real_signal = wavread('source.wav');
diff = real(sum_sign) - real_signal; %vriskw th diafora tou kanonikou shmatos apo to ypologismeno

%% 2.2 A erwthma (b)

subplot(221);
plot(real_signal);
title('Katharo Shma Fwnhs');

subplot(222);
central_mic = wavread('sensor_3.wav');
plot(central_mic);
title('Thoryvwdes Shma sto Kentriko Mikrofwno');

subplot(223);
plot(real(sum_sign));
title('Eksodos tou delay-and-sum beamformer');

subplot(224);
plot(diff);
title('Diafora Shmatwn');

figure(2);
spectrogram(real_signal,960,480);
title('Katharo Shma Fwnhs');

figure(3);
spectrogram(central_mic,960,480);
title('Thoryvwdes Shma sto Kentriko Mikrofwno');

figure(4);
spectrogram(sum_sign,960,480);
title('Eksodos tou delay-and-sum beamformer')

%% 2.2 A erwthma (c)

%Ypologismos SSNR
Seg_SNR_Central_Mic = SegmentalSNR(central_mic,100) %epilegw na spasw t shma se 100 para8yra dhladh peripou 30ms ana para8yro
Seg_SNR_Out  = SegmentalSNR(real(sum_sign),100) %epilegw na spasw t shma se 100 para8yra

