% The figure descriptions are located in the name of each window

% DISCLAIMER: In order to run, the code needs a zpd.m function that takes a
% vector of zeroes and a vector of poles, and places them on the complex plane. 

% 1.1a defining the filters
b2 = 1/3 * ones(1, 3);
a2 = [1 zeros(1, 2)];
b4 = 1/5 * ones(1, 5);
a4 = [1 zeros(1, 4)];
b10 =  1/11 * ones(1, 11);
a10 =  [1 zeros(1, 10)];

% 1.1b
[h2, w] = freqz(b2, a2, 1000);
[h4, w] = freqz(b4, a4, 1000);
[h10, w] = freqz(b10, a10, 1000);
figure('Name', 'Amplitude Response of Moving Average Filters');
plot(w, abs(h2), w, abs(h4), w, abs(h10));
xlim([0 pi]);
figure('Name', 'Phase Response of Moving Average Filters');
plot(w, angle(h2), w, angle(h4), w, angle(h10));
xlim([0 pi]);

% 1.1c
[z2, p2, k2] = tf2zpk(b2, a2);
[z4, p4, k4] = tf2zpk(b4, a4);
[z10, p10, k10] = tf2zpk(b10, a10);
zpd(z2, p2); % zero-pole diagram for n = 2
zpd(z4, p4); % zero-pole diagram for n = 4
zpd(z10, p10); % zero-pole diagram for n = 10

% 1.2a
z = [1.2 -0.6]';
p = [0.68-0.51i 0.68+0.51i]';
zpd(z, p); % zero-pole diagram for filter of 1.2a
[b, a] = zp2tf(z, p, 1);

% 1.2b
[h, w] = freqz(a, b, 1000);
figure('Name', 'Amplitude Response of 1.2b filter');
plot(w, abs(h));
xlim([0 pi]);
figure('Name', 'Phase Response of 1.2b filter');
plot(w, angle(h));
xlim([0 pi]);

% 1.2c
[h, t] = impz(b, a);
figure('Name', 'Impulse Response of 1.2c filter');
plot(t, h);
[u, t] = stepz(b, a);
figure('Name', 'Step Response of 1.2c filter');
plot(t, u);

% 1.2d
p = [0.76-0.57i 0.76+0.57i]';
[b, a] = zp2tf(z, p, 1);
[h, w] = freqz(b, a, 1000);
figure('Name', 'Amplitude response for {0.76+-0.57i}');
plot(w, abs(h));
[h, t] = stepz(b, a);
figure('Name', 'Step response for {0.76+-0.57i}');
plot(t, h);

p = [0.8-0.6i 0.8+0.6i]';
[b, a] = zp2tf(z, p, 1);
[h, t] = stepz(b, a);
figure('Name', 'Step response for {0.8+-0.6i}');
plot(t, h);

p = [0.84-0.63i 0.84+0.64i]';
[b, a] = zp2tf(z, p, 1);
[h, t] = stepz(b, a);
figure('Name', 'Step response for {0.84+-0.63i}');
plot(t, h);

% 1.2e
p = [0.68-0.51i 0.68+0.51i]';
[b, a] = zp2tf(z, p, 1);

[x, t] = gensig('pulse', 50, 100, 1);
y = filter(b, a, x);
figure('Name', 'Output for T=50s');
plot(t, y);

[x, t] = gensig('pulse', 5, 100, 1);
y = filter(b, a, x);
figure('Name', 'Output for T=5s');
plot(t, y);

% 1.2f
p = [-0.8i 0.8i]';
[b, a] = zp2tf(z, p, 1);
zpd(z, p); % zero-pole diagram for +-0.8i
[b, a] = zp2tf(z, p, 1);
[h, w] = freqz(b, a, 1000);
figure('Name', 'Amplitude Response for +-0.8i');
plot(w, abs(h));
figure('Name', 'Phase Response for +-0.8i');
plot(w, angle(h));

% 2.1a
[y1, fs] = audioread('flute_note.wav');
[y2, fs] = audioread('clarinet_note.wav');
[y3, fs] = audioread('cello_note.wav');
% sound([y1' y2' y3'], 44100);

% 2.1b
dt = 1 / fs;
t = 0 : dt : (length(y1) * dt) - dt;
figure('Name', 'Flute in time');
plot(t, y1);

t = 0: dt : (length(y2) * dt) - dt;
figure('Name', 'Clarinet in time');
plot(t, y2);

t = 0 : dt : (length(y3) * dt) - dt;
figure('Name', 'Cello in time');
plot(t, y3);

% 2.1c
w = linspace(0, 44099, 44100);
Y1 = fft(y1, 44100);
figure('Name', 'Amplitude response for flute');
plot(w, abs(Y1));
figure('Name', 'Phase response for flute');
plot(w, angle(Y1));

Y2 = fft(y2, 44100);
figure('Name', 'Amplitude response for clarinet');
plot(w, abs(Y2));
figure('Name', 'Phase response for clarinet');
plot(w, angle(Y2));

Y3 = fft(y3, 44100);
figure('Name', 'Amplitude response for cello');
plot(w, abs(Y3));
figure('Name', 'Phase response for cello');
plot(w, angle(Y3));

% 2.1e
y4 = audioread('cello_note_noisy.wav');
% sound(y4, 44100);
Y4 = fft(y4, 44100);
figure('Name','Amplitude response DFT');
plot(w,abs(Y4));

% 2.2a
y = audioread('cello_note.wav');
ycut = y(1:1850);
t = linspace(0, 1850, 1850);
figure('Name','Anaparastasi tou cello ana 10 themeliwdeis periodous');
plot(t,ycut);

% 2.2b
Y = fft(ycut, 44100);
figure('Name','Amplitude response DFT');
plot(abs(Y));
figure('Name','Phase response DFT');
plot(angle(Y));

cn = [33.6/33.6 31.3/33.6 52.5/33.6 45.5/33.6 24.2/33.6 32.5/33.6];

% 2.2c
phin = [-0.43 0.84 -1.27 1.79 2.74 2.02];

% 2.2d
t = linspace(0, 1850, 1850);
reconstructed = cn(1) * cos(2*pi*1/185*t+phin(1)) +
                cn(2) * cos(2*pi*2/185*t+phin(2)) +
                cn(3) * cos(2*pi*3/185*t+phin(3)) +
                cn(4) * cos(2*pi*4/185*t+phin(4)) +
                cn(5) * cos(2*pi*5/185*t+phin(5)) +
                cn(6) * cos(2*pi*6/185*t+phin(6));

% 2.2e
plot(t, reconstructed, t, ycut);
% sound(reconstructed);

% 2.2f
audiowrite('reconstructed.wav', reconstructed, 8192);
