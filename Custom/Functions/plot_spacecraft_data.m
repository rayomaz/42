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

    % Actuator data
    N = max(size(time));

    Trq = EnvTrq00(:,1:3);
    Mom = EnvTrq00(:,4:6);
    
    AvgTrq = mean(Trq);
    SecMom = [AvgTrq(1)*time AvgTrq(2)*time AvgTrq(3)*time];
    CycMom = Mom-SecMom;
    CycMom = CycMom - [mean(CycMom(:,1))*ones(N,1) mean(CycMom(:,2))*ones(N,1) mean(CycMom(:,3))*ones(N,1)];

    figure
    grid on
    hold on
    plot(time,Mom, 'LineWidth', 2)
    title('Accumulated Environmental Momentum', 'FontSize', 25)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel('Nms')
    legend("X", "Y", "Z", "Location", "best")

    figure
    plot(time,SecMom, 'LineWidth', 2)
    title('Secular Momentum', 'FontSize', 25)
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel('Nms')
    legend("X", "Y", "Z", "Location", "best")
    
    figure
    plot(time,CycMom, 'LineWidth', 2)
    title('Cyclic Momentum')
    xlabel("Time (s)", 'Interpreter', 'latex', 'FontSize', 25)
    ylabel('Nms')
    legend("X", "Y", "Z", "Location", "best")

end
