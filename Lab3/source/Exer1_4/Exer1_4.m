clc;
close all;
w = 2*pi*2000; %f=2kHz
theta_s = pi/2; %thitas=pi/2

%% 1.1
dist = 0.04; %orismos d gia to erwthma ayto
N = 4; %orismos N gia thn 1h periptwsh
theta = linspace(0,180,4000); 
B = BeamPattern(dist, N, theta_s, theta, w);
figure(1);
plot(theta, 20*log(abs(B)),'r');
hold on;

N = 8; %orismos N gia th 2h periptwsh
B = BeamPattern(dist, N, theta_s, theta, w);
plot(theta, 20*log(abs(B)),'g');
hold on;

N = 16; %orismos N gia th 3h periptwsh
B = BeamPattern(dist, N, theta_s, theta, w);
plot(theta,20*log(abs(B)),'b');

%% 1.2
N = 8; %orismos N gia to erwthma ayto
dist = 0.04; %orismos d gia thn 1h periptwsh
B = BeamPattern(dist, N, theta_s, theta, w);
figure(2);
plot(theta, 20*log(abs(B)),'r');
hold on;

dist = 0.08; %orismos d gia thn 2h periptwsh
B = BeamPattern(dist, N, theta_s, theta, w);
plot(theta, 20*log(abs(B)),'g');
hold on;

dist = 0.16; %orismos d gia thn 3h periptwsh
B = BeamPattern(dist, N, theta_s, theta, w);
plot(theta,20*log(abs(B)),'b');

%% 1.3
N = 8; %orismos N=8 opws leei h ekfwnhsh
w = 2*pi*2000; %f=2kHz
dist = 0.04; %orismos d=0.04 opws leei h ekfwnhsh
theta = 0; % gwnia thita=0
theta = linspace(-180,180,5000);
theta_s = 0; %orismos gwnias thita_s=0 gia thn 1h periptwsh
B= BeamPattern(dist,N,theta_s,theta,w);
figure(3);
semilogr_polar(linspace(-pi,pi,5000), (abs(B)).^2, 'r');
hold on;

theta_s = pi/4; %orismos gwnias thita_s=pi/4 gia thn 1h periptwsh
B= BeamPattern(dist,N,theta_s,theta,w);
semilogr_polar(linspace(-pi,pi,5000), (abs(B)).^2, 'g');
hold on;

theta_s = pi/2; %orismos gwnias thita_s=pi/2 gia thn 1h periptwsh
B= BeamPattern(dist,N,theta_s,theta,w);
semilogr_polar(linspace(-pi,pi,5000), (abs(B)).^2, 'b');