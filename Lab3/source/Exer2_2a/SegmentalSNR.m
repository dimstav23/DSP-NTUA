function [SSNR] = SegmentalSNR(voice,M)
% computeSSNR computes snr of 'voice' in each one of the M frames
% and then takes the average of the results (SSNR).
L = length(voice);
L = floor(L/M);
noi = sum(voice(1:L).^2); 
sum_SNR = 0;
for m=0:(M-1)
sqvoice = sum(voice((L*m+1):(L*m+L)).^2);
s = sqvoice - noi;
temp = s/noi; %checkarw an u^2>s^2
    if (temp>0)
        SNR = 10*log10(temp); %ypologismos SNR plaisiou
        if (SNR < -20) M=M-1;  %check gia th timh tou
        elseif (SNR > 35)sum_SNR = sum_SNR +35;
        else sum_SNR = sum_SNR + SNR;
        end
    else M = M-1;
    end
end
SSNR = sum_SNR/M;