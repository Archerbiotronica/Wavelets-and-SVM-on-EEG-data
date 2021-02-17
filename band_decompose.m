clc; clear ; close all;

%% wavelet packet transform
%wavelet packet decomposition
wavelet='coif4';                     % type of wavelet used
y = importdata('S\S001.txt'); y = y';
y = y(1:4096);
wpt = wpdec(y,5,wavelet);

% Recompose packet 
wpt = wpjoin(wpt,[1 1]);
wpt = wpjoin(wpt,[3 2]);
wpt = wpjoin(wpt,[3 3]);
wpt = wpjoin(wpt,[1 1]);
wpt = wpsplt(wpt,[5 1]);

% Plot wavelet packet tree wpt. 
plot(wpt)

%extracting bands 
delta=wprcoef(wpt,[5 0])+wprcoef(wpt,[6 2]);
theta=wprcoef(wpt,[6 3])+wprcoef(wpt,[5 2]);
alpha=wprcoef(wpt,[5 3])+wprcoef(wpt,[5 4]);
beta =wprcoef(wpt,[5 5])+wprcoef(wpt,[5 6])+wprcoef(wpt,[5 7])+wprcoef(wpt,[3 2]);
gamma=wprcoef(wpt,[3 3])+wprcoef(wpt,[1 1]);

% Reconstruct original
r=delta+theta+alpha+beta+gamma;

% checking reconstucted signal 
if max(abs(r-y))<=0.000001  
    disp("ok");
else
    disp("not ok");
end
% plotting signals 
figure; 
subplot(611);plot(y); title('Original Signal');grid on;
subplot(612);plot(delta); title('delta');
subplot(613);plot(theta); title('theta');
subplot(614);plot(alpha); title('alpha');
subplot(615);plot(beta) ; title('beta') ;
subplot(616);plot(gamma); title('gamma');

%% for fft 
% Fs = 173.61;          % Sampling frequency                    
% T = 1/Fs;             % Sampling period       
% l = 4096;             % Length of signal
% t = (-l/2+1:l/2)*T;   % Time vector
% f = Fs*(0:(l/2))/l;

% Y = fft(y);
% P2 = abs(Y/l);
% P1 = P2(1:l/2+1);
% P1(2:end-1) = 2*P1(2:end-1);
% 
% figure;
% plot(f,P1);
% title('Single-Sided Amplitude Spectrum of S(t)');
% xlabel('f (Hz)');
% ylabel('|P1(f)|');
