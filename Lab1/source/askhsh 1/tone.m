function [t] = tone (nmb)
%H sunarthsh ayth dhmiourgei ton tono numb mhkous 1000 deigmatwn
L=1000;
n=1:L;
[w3,w4]=givetones(nmb);
t=sin(w3*n)+sin(w4*n);
end