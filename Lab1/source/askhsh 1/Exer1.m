%% Erwthma 1.1 

%create the matrix of tones which is a 1000X10 matrix
for(i=1:10)
    d(:,i)= tone(i);
end

%An h8ela na akousw tous hxous to kanw me to parakatw kommati kwdika :
%for(i=1:10)
%   sound(d(:,i));
%   pause ;
%end


%% Erwthma 1.2

% create DFT of signals d1 and d8
D1=abs(fft(d(:,1))); 
figure;
plot(D1);
xlabel ('k')
ylabel ('|D1[k]|')
D8=abs(fft(d(:,8)));
figure;
plot(D8);
xlabel ('k')
ylabel ('|D8[k]|')



%% Erwthma 1.3 

%AM1= 03112083, AM2=03112017 ara xrhsimopoiw ws AM to: 06224100
%Ftiaxnw olous tous tonous kai oxi mono autous tou parapanw AM dioti 8a mou
%xreiastoun sto erwthma 1.5 opou 8a xrhsimopoihsw ton parakatw pinaka s_tone

d1= tone (1);
d2= tone (2);
d3= tone (3);
d4= tone (4);
d5= tone (5);
d6= tone (6);
d7= tone (7);
d8= tone (8);
d9= tone (9);
d0= tone (10);
sil = zeros (1,100);
s= [d0 sil d6 sil d2 sil d2 sil d4 sil d1 sil d0 sil d0];
s_tone= [d1 sil d2 sil d3 sil d4 sil d5 sil d6 sil d7 sil d8 sil d9 sil d0];
wavwrite (s,8192, 'tone_sequence_new.wav');

%% Erwthma 1.4 

Nm= 1000;
%creating a hamming window
w_ham= hamming(Nm);
%creating a rectangular window
w_rec= ones(1,Nm);

%Twra pollaplasiazw ka8e tono me ena para8uro, stoixeio pros stoixeiO.
%Den ksexnw oti exw kai 100 mhdenika deigmata keno metaksu ka8etonou ston 
%pinaka s. Meta xrhsimopoiw thn sunarthsh fft gia
%na parw ton met/smo Fourier twn para8uropoihmenwn shmatwn. 

%for rectangular window
fft_rect1= fft(w_rec.*s(1:1000));
fft_rect2= fft(w_rec.*s(1101:2100));
fft_rect3= fft(w_rec.*s(2201:3200));
fft_rect4= fft(w_rec.*s(3301:4300));
fft_rect5= fft(w_rec.*s(4401:5400));
fft_rect6= fft(w_rec.*s(5501:6500));
fft_rect7= fft(w_rec.*s(6601:7600));
fft_rect8= fft(w_rec.*s(7701:8700));

%for hamming window
fft_ham1= fft(w_ham'.*s(1:1000));
fft_ham2= fft(w_ham'.*s(1101:2100));
fft_ham3= fft(w_ham'.*s(2201:3200));
fft_ham4= fft(w_ham'.*s(3301:4300));
fft_ham5= fft(w_ham'.*s(4401:5400));
fft_ham6= fft(w_ham'.*s(5501:6500));
fft_ham7= fft(w_ham'.*s(6601:7600));
fft_ham8= fft(w_ham'.*s(7701:8700));

%Gia na ginei antilhpth h diafora metaksu tou hamming kai tou rectangular
%window 8a kanw mia sugrkish autwn meswn twn grafikwn fft_ham1 kai
%fft_rect1.

figure ;
subplot(1,2,1), plot(abs(fft_rect1));
xlabel('k');
ylabel('Rectangular windowed signal');
subplot(1,2,2), plot(abs(fft_ham1));
xlabel('k');
ylabel('Hamming windowed signal');

%Koitazwntas to parapanw grafhma parathrw oti to hamming para8uro dinei
%polu kalutero apotelesma se sxesh me to rectangular para8uro.


%% Erwthma 1.5 

%Edw 8elw na kanw peak detection dhladh 8elw na vrw gia ka8e tono pou
%vriskete mesa ston pinaka s_tone=[1234567890] poia einai ta eggutera k stis
%touch_one suxnothtes.Twra epanalambanw auto pou ekana sto prohgoumeno
%erwthma mono pou xrhsimopoiw ton pinaka s_tone=[1234567890] anti tou s.

fft_ham_tone1= fft(w_ham'.*s_tone(1:1000));
fft_ham_tone2= fft(w_ham'.*s_tone(1101:2100));
fft_ham_tone3= fft(w_ham'.*s_tone(2201:3200));
fft_ham_tone4= fft(w_ham'.*s_tone(3301:4300));
fft_ham_tone5= fft(w_ham'.*s_tone(4401:5400));
fft_ham_tone6= fft(w_ham'.*s_tone(5501:6500));
fft_ham_tone7= fft(w_ham'.*s_tone(6601:7600));
fft_ham_tone8= fft(w_ham'.*s_tone(7701:8700));
fft_ham_tone9= fft(w_ham'.*s_tone(8801:9800));
fft_ham_tone0= fft(w_ham'.*s_tone(9901:10900));


%Parathrw ola ta diagrammta twn para8uropoihmenwn
%shmatwn fft_ham_tone1 ews ff_ham_tone0 kai parathrw oti to hamming para8uro  
%dinei kalutera apotelesmata kai oti ta zhtoumena k ikanopoioun thn sun8hkh oti to 
%platos tous einai megalutero apo 205(oso afora to hamming window afou me auto 
%epeleksa na doulepsw). Anazhtw loipon ta k gia ta opoia isxuei auth h
%sun8hkh:

p1= find(abs(fft_ham_tone1)>205);
p2= find(abs(fft_ham_tone2)>205);
p3= find(abs(fft_ham_tone3)>205);
p4= find(abs(fft_ham_tone4)>205);
p5= find(abs(fft_ham_tone5)>205);
p6= find(abs(fft_ham_tone6)>205);
p7= find(abs(fft_ham_tone7)>205);
p8= find(abs(fft_ham_tone8)>205);
p9= find(abs(fft_ham_tone9)>205);
p10= find(abs(fft_ham_tone0)>205);

%Ta p1-p10 einai dianusmata grammh me 4 stoixeia to ka8ena.
%Epeidh mporw na upologisw tis idanikes times tou k(des anafora) parathrw oti
%kamia den upervainei to 200, ki epeidh o DFT einai summetrikos mporw na
%pw oti ta zhtoumena k gia ka8e tono einai auta pou einai mikrotera
%apo 500. Ara o parakatw pinakas k_list 8a periexei ta 2 eggutera k stis
%touch_one suxnothtes ka8e tonou.O pinakas k_list 8a einai mia lista opou 
%ana 2 times 8a einai ta zhtoumena k gia ka8e tono tou touch-pad.

t=1;
for i= 1:4
    if p1(i) < 200 
        k_list(t)=p1(i);
        t=t+1;
    end
end

for i= 1:4
    if p2(i) < 200 
        k_list(t)=p2(i);
        t=t+1;
    end
end

for i= 1:4
    if p3(i) < 200 
        k_list(t)=p3(i);
        t=t+1;
    end
end

for i= 1:4
    if p4(i) < 200 
        k_list(t)=p4(i);
        t=t+1;
    end
end

for i= 1:4
    if p5(i) < 200 
        k_list(t)=p5(i);
        t=t+1;
    end
end

for i= 1:4
    if p6(i) < 200 
        k_list(t)=p6(i);
        t=t+1;
    end
end

for i= 1:4
    if p7(i) < 200 
        k_list(t)=p7(i);
        t=t+1;
    end
end

for i= 1:4
    if p8(i) < 200 
        k_list(t)=p8(i);
        t=t+1;
    end
end
for i= 1:4
    if p9(i) < 200 
        k_list(t)=p9(i);
        t=t+1;
    end
end
for i= 1:4
    if p10(i) < 200 
        k_list(t)=p10(i);
        t=t+1;
    end
end

%Perittes 8eseis toy k_list--> suxnothtes grammwn(xamhles suxnothtes)
%Arties 8eseis toy k_list--> suxnothtes sthlwn(upshles suxnothtes)

yy=2*pi/1000;
k_list_new=k_list*yy;

%O pinakas k_lst_new exei pleon tis kuklikes suxnothtes w pou einai eggutera
%stis 8ewrhtikes times(oi opoies uparxoun sthn ekfwnhsh ths askhshs).


%% Erwthma 1.6 

ttdecode (s);


%% Erwthma 1.7

load ('my_touchtones.mat');
easy=ttdecode (easySig);
hard=ttdecode (hardSig);

%If you want to see the digits of easySig or/and hardSig press in command
%line easy or/and hard kai you will see them. Also these results are in the
%report.
