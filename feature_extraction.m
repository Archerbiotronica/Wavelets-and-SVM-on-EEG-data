clc; clear ; close all;

%% wavelet packet transform
%wavelet packet decomposition
N=4096;
wavelet='coif4';                     % type of wavelet used
data_N=zeros(100,15);
data_S=zeros(100,15);

for i=1:100
file=num2str(i,'%03.f');
y = importdata(strcat('N\N',file,'.txt')); y = y';
y = y(1:4096);
wpt = wpdec(y,5,wavelet);

% decompose level 5 packet 
wpt = wpsplt(wpt,[5 1]);

%extracting bands 
delta=wprcoef(wpt,[5 0])+wprcoef(wpt,[6 2]);
theta=wprcoef(wpt,[6 3])+wprcoef(wpt,[5 2]);
alpha=wprcoef(wpt,[5 3])+wprcoef(wpt,[5 4]);
beta =wprcoef(wpt,[5 5])+wprcoef(wpt,[5 6])+wprcoef(wpt,[5 7])+wprcoef(wpt,[3 2]);
gamma=wprcoef(wpt,[3 3])+wprcoef(wpt,[1 1]);

data_N(i,1:5)  =[std(delta),std(theta),std(alpha),std(beta),std(gamma)];        % std deviation
data_N(i,6:10) =[rms(delta),rms(theta),rms(alpha),rms(beta),rms(gamma)];        % rms
data_N(i,11:15)=N*[rms(delta),rms(theta),rms(alpha),rms(beta),rms(gamma)].^2;   % energy
end

for i=1:100
file=num2str(i,'%03.f');
y = importdata(strcat('S\S',file,'.txt')); y = y';
y = y(1:4096);
wpt = wpdec(y,5,wavelet);

% decompose level 5 packet 
wpt = wpsplt(wpt,[5 1]);

%extracting bands 
delta=wprcoef(wpt,[5 0])+wprcoef(wpt,[6 2]);
theta=wprcoef(wpt,[6 3])+wprcoef(wpt,[5 2]);
alpha=wprcoef(wpt,[5 3])+wprcoef(wpt,[5 4]);
beta =wprcoef(wpt,[5 5])+wprcoef(wpt,[5 6])+wprcoef(wpt,[5 7])+wprcoef(wpt,[3 2]);
gamma=wprcoef(wpt,[3 3])+wprcoef(wpt,[1 1]);

data_S(i,1:5)  =[std(delta),std(theta),std(alpha),std(beta),std(gamma)];        % std deviation
data_S(i,6:10) =[rms(delta),rms(theta),rms(alpha),rms(beta),rms(gamma)];        % rms
data_S(i,11:15)=N*[rms(delta),rms(theta),rms(alpha),rms(beta),rms(gamma)].^2;   % energy
end
save('feature_N.mat','data_N');
save('feature_S.mat','data_S');
disp('done');