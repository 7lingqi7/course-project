% pdf of Rayleigh distribution by 50 random numbers
pd = makedist('Rayleigh');
x1 = random(pd,1,50);
x = 0:0.02:6;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Rayleigh distribution by 50 random numbers');
legend('Histogram','Estimated PDF','True PDF');

% pdf of Rayleigh distribution by 5000 random numbers
pd = makedist('Rayleigh');
x1 = random(pd,1,5000);
x = 0:0.02:6;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Rayleigh distribution by 5000 random numbers');
legend('Histogram','Estimated PDF','True PDF');

% pdf of Poisson distribution by 50 random numbers
pd = makedist('Poisson','lambda',20);
x1 = random(pd,1,50);
x = 0:1:50;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Poisson distribution by 50 random numbers');
legend('Histogram','Estimated PMF','True PMF');

% pdf of Poisson distribution by 5000 random numbers
pd = makedist('Poisson','lambda',20);
x1 = random(pd,1,5000);
x = 0:1:50;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Poisson distribution by 5000 random numbers');
legend('Histogram','Estimated PMF','True PMF');

% pdf of Uniform distribution by 50 random numbers
pd = makedist('Uniform');
x1 = random(pd,1,50);
x = 0:0.02:1;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Uniform distribution by 50 random numbers');
legend('Histogram','Estimated PDF','True PDF');

% pdf of Uniform distribution by 5000 random numbers
pd = makedist('Uniform');
x1 = random(pd,1,5000);
x = 0:0.02:1;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Uniform distribution by 5000 random numbers');
legend('Histogram','Estimated PDF','True PDF');

% pdf of Exponential distribution by 50 random numbers
pd = makedist('Exponential');
x1 = random(pd,1,50);
x = 0:0.02:3;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Exponential distribution by 50 random numbers');
legend('Histogram','Estimated PDF','True PDF');

% pdf of Exponential distribution by 5000 random numbers
pd = makedist('Exponential');
x1 = random(pd,1,5000);
x = 0:0.02:3;
[f,x] = ksdensity(x1,x);
figure;
histogram(x1,'normalization','pdf'); hold on;
plot(x,f,'linewidth',1.5); hold on;
y = pdf(pd,x);
plot(x,y,'g--','linewidth',1.5);
title('Pdf of Exponential distribution by 5000 random numbers');
legend('Histogram','Estimated PDF','True PDF');