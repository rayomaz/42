function plot_spacecraft_data(time, PosN, VelN, qbn, wbn, Hvb, wn, EnvTrq00, spacecraft_type, print_flag)
    % Function to plot spacecraft data and save figures based on the print_flag

    % Plot ECI motion
    figure
    grid on
    hold on
    plot(time, PosN, 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("ECI Position [m]", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_position.png'], '-dpng', '-r500');
    end

    % Plot ECI velocity
    figure
    grid on
    hold on
    plot(time, VelN, 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("ECI Velocity [m/s]", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_velocity.png'], '-dpng', '-r500');
    end

    % Plot quaternions
    figure
    grid on
    hold on
    plot(time, qbn, 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("Quaternion", 'Interpreter', 'latex', 'FontSize', 25)
    legend("q_1", "q_2", "q_3", "q_4", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_quat.png'], '-dpng', '-r500');
    end

    % Plot Euler angles
    plotEulerAngles(time, qbn)
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_euler.png'], '-dpng', '-r500');
    end

    % Plot body rate
    figure
    grid on
    hold on
    plot(time, wbn, 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("Angular Velocity [m/s]", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_rate.png'], '-dpng', '-r500');
    end

    % Plot angular momentum (body frame)
    figure
    grid on
    hold on
    plot(time, Hvb, 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("Angular Momentum [$kg m^2/s$]", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_angular_momentum.png'], '-dpng', '-r500');
    end

    % Gyroscope data (Acceleration)
    figure
    grid on
    hold on
    plot(time, wn, 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("Acceleration $[m/s^2]$", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_gyro.png'], '-dpng', '-r500');
    end

    % External gravity gradient acceleration
    figure
    grid on
    hold on
    plot(time, EnvTrq00(:, 1:3), 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("Gravity Gradient $[m/s^2]$", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_gravity gradient.png'], '-dpng', '-r500');
    end

    % External drag acceleration
    figure
    grid on
    hold on
    plot(time, EnvTrq00(:, 4:6), 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel("Drag Acceleration $[m/s^2]$", 'Interpreter', 'latex', 'FontSize', 25)
    legend("X", "Y", "Z", "Location", "best")
    if print_flag
        print(gcf, ['Custom/Figures/', spacecraft_type, '_drag.png'], '-dpng', '-r500');
    end
end
