%% 2.1 A erwthma (a)
clear all;
close all; 
clc;
N = 7;
d = 0.04;
c = 340;
sum_sign = 0;
theta = pi/4;
for i=0:(N-1)
sensor = ['sensor_' num2str(i) '.wav']; %edw tou orizw poio sensor diavazw,apla kanw to i string gia na to vrei t matlab
sign = wavread(sensor);
shift_value = -(i-(N-1)/2)*d*cos(theta)/c;
Shifted = Shift(sign , shift_value); %efarmozw thn xronikh metatopish gia ka8e shma
sum_sign = sum_sign + Shifted; %a8roizw ta shmata apo tous sensors meta apo to katallhlo time shift
end
sum_sign = sum_sign/N; %pairnw to m.o. twn shmatwn
wavwrite(real(sum_sign), 48000,'sim_ds.wav'); %eggrafh tou shmatos
real_signal = wavread('source.wav');
diff = real(sum_sign) - real_signal; %vriskw th diafora tou kanonikou shmatos apo to ypologismeno

%% 2.1 A erwthma (b)

subplot(221);
plot(real_signal);
title('Katharo Shma Fwnhs');

subplot(222);
central_mic = wavread('sensor_3.wav'); %sto sensor 3 einai to kentriko mikrofwno pou mas afora
plot(central_mic);
title('Thwryvwdes shma sto kentriko mikrofwno');

subplot(223);
plot(real(sum_sign));
title('Eksodos tou delay-and-sum beamformer');

subplot(224);
plot(real(diff));
title('Diafora: Eksodos tou beamformer - Katharo Shma');

figure(2);
spectrogram(real_signal,960,480);
title('Katharo Shma Fwnhs');

figure(3);
spectrogram(central_mic,960,480);
title('Thoryvwdes Shma sto Kentriko Mikrofwno');

figure(4);
spectrogram(sum_sign,960,480);
title('Eksodos tou delay-and-sum beamformer')

%% 2.1 A erwthma (c)
%Ypologismos SNR me ton typo ths askhshs
rs_sq = sum(real_signal.^2); 
diff_sq = sum(diff.^2);
diff_central_sq = sum((real(central_mic)-real_signal).^2);
SNR_BEAM = 10*log10(rs_sq/diff_sq) 
SNR_CENTRAL_MIC = 10*log10(rs_sq/diff_central_sq)