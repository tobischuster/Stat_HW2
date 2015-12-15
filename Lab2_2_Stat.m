%% 2 Linear regression and M/G/1-PS queue

data = dlmread('data_ex2.txt','',1,0);
% Spalte 1: Capacity [mbps]
% Spalte 2: mean [s]

%% 1. 
figure('Name','dwl time as fct pf capacity','NumberTitle','off')
plot(data(:,2),data(:,1))
xlabel('mean dwl')
ylabel('capacity')


%% 2.
% (a)
T = @(s)1/((C/s)-lampda);
[x,fval] = fminsearch(T,C);

% (b)


% (c)


% (d)

%% 3.
% Redefining data points
xi = data(:,1);      % xi = capacity
yi(:,1) = data(:,2);    % yi = 1/mean time
yi(:,2) = 1/yi(:,1);

% (a)

% (b)

% (c)

% (d)
%polyfit

% (e)

% (f)

% (g)


