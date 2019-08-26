%Exercise 4.1
clear all;
[x, Fs] = wavread('speech.wav');
%8a xrhsimopoihsw th synarthsh buffer
%8a parw to shma mou se para8yra twn 30ms me overlap 20ms
y = buffer(x,0.030*48000,0.020*48000);
%dhmiourgia katallhlou para8yrou hamming 30 ms
w=hamming(0.030*48000);
%ypologizw thn ta3h tou provlepth pou 8a xrhsimopoihsw
p=Fs/1000+4;
load ('pitch.mat');
%zero-padding sto pitch mexri na apokthsei iso ari8mo shmeiwn me ayto pou
%epi8ymoume,epekteinoume t pitch apo 580 se 583 deigmata dhladh
pitch(length(pitch)+1:size(y,2)) = 0;
%trexoume mia for gia ola ta epikalyptomena para8yra pou dhmiourghsame
for i = 1:size(y,2)
    %para8yrwsh
	s(:,i) = y(:,i).*w;
	%efarmozw LPC analysis gia na vrw ta a,G ta opoia kai apo8hkeyw se enan
	%pinaka giati 8a ta xreiastw gia thn kvantish
	[a(i,:), G(i), lpc_error,speech_frame_est] = lpc_analysis(s(:,i), p);
	%ypologizw me xrhsh ths synarthshs poly2rc toys syntelestes PARCOR k(i)
	k(i,:) = poly2rc(a(i,:));
	%ypologizw me vash twn typo ths ekfwnhshs tous syntelestes g(i)
	g(i,:) = log10((1-k(i,:))./(1+k(i,:)));
	%gia thn kvantish tou pitch checkarw an exw emfwno h afwno hxo gia to
	%sygkekrimeno para8yro
	if pitch(i) ~= 0
		Pitch_Check(i) = 1;
    else
        Pitch_Check(i) = 0;
	end
end
%Meta apo ton ypologismo olwn twn parapanw kvantizoume tis times poy ypologisame
%me vash ton ari8mo to bits pou mas parexetai gia ka8e parametro
gi_Quantized = linearQ(g,5);
Pitch_Quantized = linearQ(pitch,6);
Tone_Quantized = linearQ(Pitch_Check,1);
Gain_Quantized = 10.^(linearQ(log10(G),5));
%me vash ta parapanw epipeda kvantizw tous syntelestes k(i) kai a(i)
for i = 1:size(y,2)
	ki_Quantized(i,:) = (1-10.^gi_Quantized(i,:))./(1+10.^gi_Quantized(i,:));
	ai_Quantized(i,:) = rc2poly(ki_Quantized(i,:));
end
%kanw syn8esh ths fwnhs mesw mias elafrws allagmenhs synarthshs vocoder
synthesized_voice = Quantized_Values_Voc(279563, Fs ,0.030*48000,0.020*48000,Pitch_Check,Gain_Quantized,ai_Quantized,583);

%Normalize so to have right size for wavwrite
synthesized_voice = synthesized_voice/(max(abs(synthesized_voice)));

wavwrite(synthesized_voice, Fs, 'synthesis_encoded_lpc.wav');
