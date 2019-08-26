%%2.1 B erwthma (a)
s = wavread('source.wav');
s_central = wavread('sensor_3.wav');
real_frame = s(36000:37440)'; %48000*0.75=36000 gia na parw to frame poy zhteitai
central_frame = s_central(36000:37440)'; %48000*0.78=37440
space = linspace(1,8000,240);
Ps_s = pwelch(real_frame,480,240,1441,48000,'twosided'); %eyresh fasmatos isxyos me pwelch para8yra 10 ms me epikalypsh 50%
Ps_s_central = pwelch(central_frame,480,240,1441,48000,'twosided'); %opws ypodeiknyetai sthn ekfwnhsh
noise = central_frame-real_frame;
Ps_noise = pwelch(noise,480,240,1441,48000,'twosided'); %fasma isxyos 8oryvou
Hw = 1-(Ps_noise./Ps_s_central)'; %euresh tou Hw
figure(1);
plot(space,10*log10(Hw(1:240))); %sxediash se logari8mikh klimaka

%% 2.1 B erwthma (b)
Nsd = (abs(1-Hw)).^2; %efarmogh typou gia eyresh tou Nsd
figure(2);
plot(space, 10*log10(Nsd(1:240))); %sxediash se logari8mikh klimaka

%% 2.1 B erwthma (c)
DFT_Central_Frame = fft(central_frame);
DFT_Out = Hw.*DFT_Central_Frame; %wiener filtrarisma
Out = ifft(DFT_Out);
Ps_out = pwelch(Out,480,240,1441,48000,'twosided'); %fasma isxyos e3odou wiener filtrou
figure(3);
plot(space, 10*log10(Ps_s(1:240)),'b');
hold on;
plot(space, 10*log10(Ps_s_central(1:240)),'y');
hold on;
plot(space, 10*log10(Ps_out(1:240)),'g');
hold on;
plot(space, 10*log10(Ps_noise(1:240)),'r');

%% 2.1 B erwthma (d)
real_out = ifft(Hw.*fft(real_frame)); %filtrarismeno pragmatiko frame
noise_out = ifft(Hw.*fft(noise)); %filtrarismenos 8oryvos
SNR_Real_Voice = 10*log10(mean(real_frame.^2)/mean(noise.^2))
SNR_Wiener_Filtered_Out = 10*log10(mean(real_out.^2)/mean(noise_out.^2))
N = 7; %ka8orismos parametrwn
d = 0.04;
c = 340;
sum_sign = 0;
theta = pi/4;
for i=0:(N-1)
    sensor = ['sensor_' num2str(i) '.wav'];
    signal = wavread(sensor);
    shift_value = -(i-(N-1)/2)*d*cos(theta)/c;
    Shifted = Shift(signal , shift_value);
    sum_sign = sum_sign + Shifted;
end
sum_sign = sum_sign/N; %pairnw to M.O. twn shmatwn
sum_sign = sum_sign(36000:37440)'; %pairnw to kommati pou 8elw
Ps_Beam_Pattern = pwelch(sum_sign,480,240,1441,48000,'twosided'); %fasma isxyos
figure(4);
plot(space, 20*log(Ps_s(1:240)),'b');
hold on;
plot(space, 20*log(Ps_s_central(1:240)),'y');
hold on;
plot(space, 20*log(Ps_out(1:240)),'g');
hold on;
plot(space, 20*log(Ps_Beam_Pattern(1:240)),'r');
hold on;
Noise_Beam_Pattern = real(sum_sign) - real_frame;
SNR_Delay_And_Sum_BeamPattern = 10*log10(mean(real_frame.^2)/mean(Noise_Beam_Pattern.^2))
