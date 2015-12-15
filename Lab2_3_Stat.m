%% Web server differentiation

data = dlmread('data_ex3.txt','',1,0);

%% Configuration 1

% 1. (a)
mu = 10;                        % mean
alpha = .1;                     % Significance level

% mu=10 & mu!=10 & alpha=.1
[h_1 p_1] = ttest(data,mu,'Tail','both')%,'Alpha',.1)  % h=0: no rejection of null hypothesis at 5% significane level
% 

% (b)
% mu=10 & mu>10 & alpha=.1
[h_2 p_2] = ttest(data,mu,'Tail','right','Alpha',.1) 


%  We still need to check if the second value (mu) doesnt need to be the 2.
%  data set instead of using the mean.



