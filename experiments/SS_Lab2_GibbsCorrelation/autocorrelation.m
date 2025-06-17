% Parameter settings
N = 500; % Length of the signal
t = (0:N-1)'; % Time vector

% Signal generation
x1 = cos(2*pi*0.05*t); % Generate a periodic signal x1 with frequency 0.05 cycles/sample
x2 = sin(2*pi*0.10*t); % Generate a periodic signal x2 with frequency 0.10 cycles/sample
x3 = randn(N,1); % Generate a random noise signal x3

% Compute auto-correlation functions
R11 = xcorr(x1, x1, 'unbiased'); % Auto-correlation of signal x1, normalized to be unbiased
R22 = xcorr(x2, x2, 'unbiased'); % Auto-correlation of signal x2, normalized to be unbiased
R33 = xcorr(x3, x3, 'unbiased'); % Auto-correlation of signal x3, normalized to be unbiased

% Compute cross-correlation functions
R12 = xcorr(x1, x2, 'unbiased'); % Cross-correlation between signals x1 and x2, normalized to be unbiased
R13 = xcorr(x1, x3, 'unbiased'); % Cross-correlation between signals x1 and x3, normalized to be unbiased
R23 = xcorr(x2, x3, 'unbiased'); % Cross-correlation between signals x2 and x3, normalized to be unbiased

% Plot auto-correlation functions
figure;
subplot(3,1,1);
plot(R11);
title('Auto-correlation R11');
xlabel('Lag');
ylabel('Amplitude');

subplot(3,1,2);
plot(R22);
title('Auto-correlation R22');
xlabel('Lag');
ylabel('Amplitude');

subplot(3,1,3);
plot(R33);
title('Auto-correlation R33');
xlabel('Lag');
ylabel('Amplitude');

% Plot cross-correlation functions
figure;
subplot(3,1,1);
plot(R12);
title('Cross-correlation R12');
xlabel('Lag');
ylabel('Amplitude');

subplot(3,1,2);
plot(R13);
title('Cross-correlation R13');
xlabel('Lag');
ylabel('Amplitude');

subplot(3,1,3);
plot(R23);
title('Cross-correlation R23');
xlabel('Lag');
ylabel('Amplitude');

