% exercise 3.2
close all;
clear all;
load ('pitch.mat');
[x,Fs]= wavread ('speech.wav');
x(279563:280320)=0; %zero-padding gia na exw akeraio ari8mo para8yrwn
y=buffer(x,0.020*48000, 0.010*48000); %para8yro twn 20ms me shift 10
w=hamming(0.020*48000); %para8yro gia para8yropoihsh
%280320/960 gia na vrw posa para8yra 8a xreiastw
%creating the codebook
%arxikopoihsh tou pinaka me tis diegerseis Vn
for i= 1:1024
    for j=1:960%583
        Vn(i,j)=0;
    end
end
for k = 1:1024
        Ck= raylrnd(1,1,480) ;  %dhmiourgia N=480 tyxaiwn ari8mwn ths katanomhs rayleigh
        Fk=2*pi*rand(1,480);  %dhmiourgia N=480 tyxaiwn ari8mwn Fk 
        for n=1:960
            Vn(k,n)=0;
            for j = 1:480
                Vn(k,n)=Vn(k,n)+Ck(j) * cos(pi*(j-1)*(n-1)/52+Fk(j));
            end
        end
end

for i= 1:size(y,2)
   i 
    s=y(:,i);
    %lcp_order=48 (kHz)+4
    [a,G,lpc_error,speech_frame_est]=lpc_analysis(s,52);
    %pairnw t xcorr tou error gia na vrw ta b,m 
    R=xcorr(lpc_error); %xcorr
    R=R'; %metatrepw to dianysma sthlh se dianysma grammh
    %vriskw to megisto tou pinaka pera apo to shmeio 960 pou einai to 0
    %afou to kovw
    Rsearch=R(1060:1919);
    [MaxR,MaxInd]=max(Rsearch); 
    M=MaxInd+100;
    b(1:960)=0;
    b(M)=R(M)/R(960); %to kanw R ths meshs to r(1)
    %vrhka syntelestes tou long term predictor 
    %pernaw tis Vn apo to filtro 1/1-b*z^-M
      for j=1:1024
        Vn_filtered(j,:)=filter(1,[1 -b],Vn(j,:));%!!!!!!!!!!!
        %Vn(i)=filter(a,G,Vn(i));
        Vn_filtered(j,:)=filter(G,a,Vn_filtered(j,:));%!!!!!!!!!!
        energy_find=(s-Vn_filtered(j,:)').^2; %vriskw thn energeia ths diaforas
        energy(j)=sum(energy_find);
      end
    %vriskw to min energy gia ka8e frame 
	[min_energy(i),index]=min(energy);%vriskw thn elaxisth energeia kai th 8esh tou
    Pulse(i,:)=Vn_filtered(index,:);%vriskw thn katallhlh diegersh me to mikrotero error
    
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

wavwrite (final_sign',48000,'synthesis_celp') ;
figure;
[S,F,T,P] = spectrogram(final_sign, 960, 480, nextpow2(length(x)), Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
title('Spectogram of Reconstructed Voice');
xlabel('Time (Seconds)'); ylabel('Hz');
figure;
plot (final_sign');
title('Reconstructed Voice');