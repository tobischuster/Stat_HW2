%% Import data
m1=textread('147.32.125.132.loss.txt');
m2=textread('195.204.26.25.loss.txt');

%% 1.1.1 Data Cleaning (Histogram and CDF)

% Before cleaning
figure('Name','Histogram before cleaning','NumberTitle','off')
hist(m1,10000)

% After cleaning
figure('Name','Histogram after cleaning','NumberTitle','off')
hist(m1,10000)
xlim([0.85 20])  % Proposed thresholds
figure('Name','Histogram after cleaning DATA 2','NumberTitle','off')
hist(m2,30000)
xlim([1 10])

m1c = m1;
m1c(m1c>20) = []; 
m1c(m1c<.85) = [] ;

m2c = m2 ; 
m2c(m2c>10) = []; 
m2c(m2c<1) = [] ;
figure(4)
hist(m1c,600)
xlim([.8 20])

figure('Name','CDF after cleaning','NumberTitle','off')
[x_1,y_1] = ecdf(m1c);
plot(y_1,x_1);

[x_2,y_2] = ecdf(m2c);
%plot(y_1,x_1);


%figure(4)
%[z,w] = ecdf(m2c);
%plot(w,z)


%% 1.1.2 Analysis

% 2.
% Empirical mean
mean_m1 = mean(m1c);

% Bootstrap method
ci_m1 = bootci(1000,@mean,m1c) % confidence interval

% Central limit theorem


% Compare and Comment


% 3. (a)
% m1
%ccdf_m1 = 1-ecdf(m1c); 
figure('Name','CCDF data set 1','NumberTitle','off')
%semilogy(y,1-x,'.') % zur basis 10 = semilog
plot(y_1,log(1-x_1),'.') % zur basis e = ln

%m2
figure('Name','CCDF data set 2','NumberTitle','off')
plot(y_1,log(1-x_1),'.')

% 3. (b)
% m1
[x_1,y_1] = ecdf(m1c);
[estimate_m1 muci_1] = expfit(1-x_1) %--> Need to check if exponential distribution
% estimate_m1 = exp distribution mean 
% m2
[x_1,y_1] = ecdf(m1c);
[estimate_m2 muci_2] = expfit(1-x_2)

% 3. (c)
% m1
% chi2gof is testing for normal distribution 
% SUM((observed counts-expected counts).^.2/expected)
h = chi2gof(m1)%,'cdf',@expcdf)   % h == 1 --> rejection else 0 = OK
if (h == 1) {fprintf('Reject')}
else {fprintf('OK')}
end
% Original data follows the normal distribution because h=0, so chi2gov
% does not reject the 0 hypothesis at 5%

% 3. (d)
% [x_1,y_1] = ecdf(m1c);
% [estimate_m1_d muci_1_d] = expfit()
% h_2 = chi2gof(m1c)
% redo (b) -(c) with m1c
% Compare to (b) and (c)

%% 1.2 File size distribution
load('sizes.mat')

% 1.
[size_x size_y] = ecdf(sizes);
plot(size_y,size_x)
hist(size_x,1000)
ccdf_size = 1 - size_x;
figure('Name','CCDF of size.mat','NumberTitle','off')
plot(size_y,ccdf_size) %--> Heavy Tail according to script(3.26)
figure('Name','CCDF of size.mat logarithmic','NumberTitle','off')
semilogy(size_y,ccdf_size)
figure('Name','CCDF of loglog')
%plot(log(size_y),log(ccdf_size))
loglog(size_y,ccdf_size)

% 2. 
% f = 2;          %--> Choose free
% %a = 1:8;
% len = length(sizes);
% m = mean(sizes);
% X = sizes;
% X = X-m;
% %von=(32-1)*+1;
% %bis=i*2;
% colors = ['r';'b';'g';'c';'m';'r';'b';'m'];
% figure(6)
% for a=1:8
%     X = X * f^a;
%     [X_ecdf,w] = ecdf(X);
%     X_ccdf = 1-X_ecdf;
%     %X = X * f^a;
%     hold on
%     loglog(X_ccdf,colors(a))
%     %plot(X_ccdf,colors(a))
% end
% hold off
figure(69)
X = sizes;
for m_1 = 1:3:8
    m = 2^m_1;
%X = X-mean(X);
parfor i=1:round(length(X)/100)
    Xtaq=sum(X((i-1)*m+1:i*m));
end
[t mau]=ecdf(Xtaq(:,m_1));
t_ccdf = 1-t;
hold on
plot(mau,t_ccdf)
set(gca,'yscale','log')
set(gca,'xscale','log')
end

figure(66)
hold on
for xxx=1:8
plot(mau(:,xxx),t_ccdf(:,xxx))
set(gca,'yscale','log')
set(gca,'xscale','log')
end
hold off
%loglog(t_ccdf)

colors = ['r';'b';'g';'c';'m';'r';'b';'m'];
figure(7)
u=1:20 
for a=1:8
    hold onc
    fctn=5*u+a;
    plot(u,fctn,colors(a))
end
hold off

