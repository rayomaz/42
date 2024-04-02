%% Calling 42 C code through Matlab interface
% Rayan Mazouz, Marco Quadrelli
% Verification: Orbits and Attitude

clc; clear; close all;

% Call 42
output = system('./42 Custom');

% Load data
load ./Custom/time.42
load ./Custom/PosN.42
load ./Custom/VelN.42
load ./Custom/qbn.42
load ./Custom/wbn.42

% Plot eci motion
figure
grid on
hold on
plot(time, PosN, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("ECI Position [m]", 'Interpreter','latex', "FontSize", 25)
legend("X", "Y", "Z", "Location", "best")

% Plot eci velocity
figure
grid on
hold on
plot(time, VelN, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("ECI Velocity [m/s]", 'Interpreter','latex', "FontSize", 25)
legend("X", "Y", "Z", "Location", "best")

% Plot quaternions
figure
grid on
hold on
plot(time, qbn, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("Quaternion", 'Interpreter','latex', "FontSize", 25)
legend("q_1", "q_2", "q_3", "q_4", "Location", "best")

% Plot Euler angles
plotEulerAngles(time, qbn)

% Plot body rate
% figure
% grid on
% hold on
% plot(time, wbn, 'LineWidth', 2)
% xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
% ylabel("Angular Velocity [m/s]", 'Interpreter','latex', "FontSize", 25)
% legend("X", "Y", "Z", "Location", "best")