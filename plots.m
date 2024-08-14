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

% External gravity gradient acceleration
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
