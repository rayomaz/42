%% Calling 42 C code through Matlab interface
% Rayan Mazouz, Marco Quadrelli
% Verification: Orbits and Attitude

clc; clear; close all;

%% Call 42
spacecraft_type = 'Sphere'; %'Custom'; 
output = system(['./42 Custom/', spacecraft_type]);
base_path = ['./Custom/', spacecraft_type, '/'];

%% Load data
load([base_path, 'time.42']);
load([base_path, 'PosN.42']);
load([base_path, 'VelN.42']);
load([base_path, 'qbn.42']);
load([base_path, 'wbn.42']);

load([base_path, 'Hvb.42']); % Angular momentum body frame 
load([base_path, 'Hvn.42']); % Angular momentum inertial frame

load([base_path, 'Gyro.42']); % Extract gyroscope data
[wn, trueRate, Bias, Angle, measRate, AC_wbn] = gyro_data(Gyro);

load([base_path, 'EnvTrq00.42']); % Extract torque
L = external_torques(time, Hvb); % Compute total external torque

%% Plots
% Plot eci motion
figure
grid on
hold on
plot(time, PosN, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("ECI Position [m]", 'Interpreter','latex', "FontSize", 25)
legend("X", "Y", "Z", "Location", "best")
print(gcf, ['Custom/Figures/', spacecraft_type, '_position.png'], '-dpng', '-r500');

% Plot eci velocity
figure
grid on
hold on
plot(time, VelN, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("ECI Velocity [m/s]", 'Interpreter','latex', "FontSize", 25)
legend("X", "Y", "Z", "Location", "best")
print(gcf,['Custom/Figures/', spacecraft_type, '_velocity.png'],'-dpng','-r500') 

% Plot quaternions
figure
grid on
hold on
plot(time, qbn, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("Quaternion", 'Interpreter','latex', "FontSize", 25)
legend("q_1", "q_2", "q_3", "q_4", "Location", "best")
print(gcf,['Custom/Figures/', spacecraft_type, '_quat.png'],'-dpng','-r500') 

% Plot Euler angles
plotEulerAngles(time, qbn)
print(gcf,['Custom/Figures/', spacecraft_type, '_euler.png'],'-dpng','-r500') 

% Plot body rate
figure
grid on
hold on
plot(time, wbn, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("Angular Velocity [m/s]", 'Interpreter','latex', "FontSize", 25)
legend("X", "Y", "Z", "Location", "best")
print(gcf,['Custom/Figures/', spacecraft_type, '_rate.png'],'-dpng','-r500') 

% Plot angular momentum (body frame)
figure
grid on
hold on
plot(time, Hvb, 'LineWidth', 2)
xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
ylabel("Angular Momentum [$kg m^2/s$]", 'Interpreter','latex', "FontSize", 25)
legend("X", "Y", "Z", "Location", "best")
print(gcf,['Custom/Figures/', spacecraft_type, '_angular_momentum.png'],'-dpng','-r500') 

% Gyroscope data (Acceleration)
figure
grid on
hold on
plot(time, wn, 'LineWidth', 2);
xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25);
ylabel("Acceleration $[m/s^2]$", 'Interpreter', 'latex', 'FontSize', 25);
legend("X", "Y", "Z", "Location", "best")
print(gcf, ['Custom/Figures/', spacecraft_type, '_gyro.png'], '-dpng', '-r500');

% External gravity gradient acceleratio
figure
grid on
hold on
plot(time, EnvTrq00(:, 1:3), 'LineWidth', 2);
xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25);
ylabel("Gravity Gradient $[m/s^2]$",'Interpreter', 'latex', 'FontSize', 25);
legend("X", "Y", "Z", "Location", "best")
print(gcf, ['Custom/Figures/', spacecraft_type, '_gravity gradient.png'], '-dpng', '-r500');

% External drag acceleration
figure
grid on
hold on
plot(time, EnvTrq00(:, 4:6), 'LineWidth', 2);
xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25);
ylabel("Drag Acceleration $[m/s^2]$", 'Interpreter', 'latex', 'FontSize', 25);
legend("X", "Y", "Z", "Location", "best")
print(gcf, ['Custom/Figures/', spacecraft_type, '_drag.png'], '-dpng', '-r500');

% External torque
figure
grid on
hold on
plot(time(1:end-1), L, 'LineWidth', 2);
xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25);
ylabel("Torque [Nm]", 'Interpreter', 'latex', 'FontSize', 25);
legend("X", "Y", "Z", "Location", "best")
print(gcf, ['Custom/Figures/', spacecraft_type, '_torques.png'], '-dpng', '-r500');

% Close
close all

%% Functions

% Extract gyroscope data
function [wn, trueRate, Bias, Angle, measRate, AC_wbn] = gyro_data(Gyro)
    wn = Gyro(:, 1:3);
    trueRate = Gyro(:, 4:6);
    Bias = Gyro(:, 7:9);
    Angle = Gyro(:, 10:12);
    measRate = Gyro(:, 13:15);
    AC_wbn = Gyro(:, 16:18);
end

% Compute external torques
function L = external_torques(time, H)
    
    L = zeros(3, length(time) - 1);
    
    for kk = 1:3

        for jj = 1:(length(time) - 1)
    
            dH = H(jj + 1, kk) - H(jj, kk);
            dt = time(jj + 1) - time(jj);
            
            L(kk, jj) = dH / dt;
    
        end
    end
    
end



