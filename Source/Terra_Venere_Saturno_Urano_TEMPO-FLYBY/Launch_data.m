%% COMPUTATION OF LAUNCH DATA FROM KOUROU BASE

addpath("./Script matlab/")

hour = 0:1:24;

lst_min = LST(2022, 01, 01, hour, -52.8); % sidereal time 1/1/2022
lst_max = LST(2022, 02, 28, hour, -52.8); % sidereal time 28/2/2022
%  -52.8 = latitude of Kourou base

% Comparison between sidereal time of two days
figure(1)
subplot(2, 1, 1)
plot(hour, lst_min);
xlabel('ora')
ylabel('LST_01_01_2022')
grid on

subplot(2, 1, 2)
plot(hour, lst_max);
xlabel('ora')
ylabel('LST_28_02_2022')
grid on

%% Launch data sidereal time
lst_launch = LST(2022, 01, 01, hour, -52.8);
ninety = 90 + 0*hour;  % desired sidereal time
figure(2)
plot(hour, lst_launch, hour, ninety);
xlabel('ora')
ylabel('LST_01_02_2022')
grid on
