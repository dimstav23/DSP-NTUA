% exercise 1 
close all
clear all
[x,Fs]= wavread ('speech.wav');
y=buffer(x,0.030*48000, 0.020*48000);
w=hamming(0.030*48000);
%vriskw ta oria t pitch afou exoume andrikh fwnh
%ta oria ta ka8orizw apo 80 mexri 250 Hz
limit_down=48000/50;
limit_up=48000/250;
for i= 1:size(y,2)
   vv=y(:,i).*w ;
   cepstrum=rceps(vv);
   new_ceps=cepstrum(limit_up:limit_down);
   [maxi(i),index(i)]=max(abs(new_ceps));
 
end
%find the frequencies
for i=1:580
    if abs(maxi(i))<0.0591
        f0(i)=0;
    else
        f0(i)=Fs/(index(i)+191);
    end
end
figure;
freq=medfilt1(f0,9); 
load('pitch.mat');
y1 = freq(1:580);
y2 = pitch';
plot(t,y1,t,y2)