% exercise 3
clear all;
[x,Fs]= wavread ('speech.wav');
x(279563:280320)=0; %zero-padding gia na exw akeraio ari8mo para8yrwn
y=buffer(x,0.020*48000, 0.010*48000); %para8yro twn 20ms me shift 10
w=hamming(0.020*48000); %para8yro gia para8yropoihsh
%280320/960 gia na vrw posa para8yra 8a xreiastw
%creating the codebook
%arxikopoihsh tou pinaka me tis diegerseis Vn
load ('pitch.mat')
pitch_zp = [pitch zeros(1,size(y,2)-length(pitch))]; %zeropadding sto pitch
for i= 1:size(y,2)
   i 
    s=y(:,i);
    [a,G,lpc_error,speech_frame_est]=lpc_analysis(s,52);
    %vriskoume me th me8odo xcorr thn aytosysxetish tou lpc_error
    R=xcorr(lpc_error); %xcorr
    R=R'; %metatrepw to dianysma sthlh se dianysma grammh
    %vriskw to megisto tou pinaka pera apo to shmeio 0
    Rsearch=R(1060:1919);
    [MaxR,MaxInd]=max(Rsearch); %se olo to R<<=========
    M=MaxInd+100;
    b(1:960)=0;
    b(M)=R(M)/R(960); %to kanw R ths meshs to r(1)
    %vrhka syntelestes tou long term predictor
    %pernaw tis Vn apo to filtro 1/1-b*z^-M
    f = pitch_zp(i);
    u = ugenerator(f,960,Fs);
    Pulse(i,:)=filter(G,a,u);%!!!!!!!!!!!
    %Vn(i)=filter(a,G,Vn(i));
    Pulse(i,:)=filter(1,[1 -b],Pulse(i,:));%!!!!!!!!!!
        
   %plotarw ta errors se antiparavolh me t shma
     if i>87 && i<92
        estimation=Pulse(i,:)';
        ltp_error=s-estimation;
        figure; 
        subplot (3,1,1);
        plot(lpc_error);
        title ('error by lpc analysis')
        subplot (3,1,2);
        plot(ltp_error);
        title ('error by ltp analysis')
        subplot (3,1,3);
        plot (s);
        title('original windowed frame');
     end
end
count=1;
%reconstruct of the voice
Pulse=Pulse';
%overlap and add
for i=1:280320
    final_sign(i)=0; %final_sign= zeros(1,280320);
end


helper=1;
for i=1:584
 current_frame=Pulse(:,i);
 windowedframe=w.*current_frame;
 segstart=helper;
 segend=segstart+960-1;
 if i==584
    segend=280320;
    segstart=280320-959;
 end
 final_sign(segstart:segend)= final_sign(segstart:segend) + windowedframe'; 
 helper=helper+480;
end
%scaling and normalising
final_sign = final_sign/max(final_sign); 
figure;

wavwrite (final_sign',48000,'synthesis31') ;
figure;
[S,F,T,P] = spectrogram(final_sign, 960, 480, nextpow2(length(x)), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
title('Spectogram of Reconstructed Voice');
xlabel('Time (Seconds)'); ylabel('Hz');
figure;
plot (final_sign');