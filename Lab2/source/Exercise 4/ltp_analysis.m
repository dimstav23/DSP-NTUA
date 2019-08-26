function [b,M] = ltp_analysis(lpc_error)
%pairnw thn aytosysxetish tou error pou prokyptei apo thn lpc analysis gia
%ka8e frame
R = xcorr(lpc_error);
R=R'; %metatrepw to dianysma sthlh se dianysma grammh
%vriskw to megisto tou pinaka pera apo to shmeio 0 anazhtwntas apo ta 100
%deigmata kai meta
Rsearch=R(1540:2879);
[MaxR,MaxInd]=max(Rsearch); 
 M=MaxInd+100; %ry8mizw swsta to index mou
 b(1:1440)=0;%ta ypoloipa 0
 b(M)=R(M)/R(1440); %sth M+1 8esh tou b topo8etw thn katallhlh timh gia na 
 %dhmiourgh8ei swsta to filter
%exw etoimo dhladh to filtro ths LTP analysis
