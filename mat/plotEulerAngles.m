function plotEulerAngles(time, qbn)

    euler_angles = zeros(3, length(qbn));
    for jj = 1:length(qbn)
        
        q1 = qbn(jj, 1);
        q2 = qbn(jj, 2);
        q3 = qbn(jj, 3);
        q4 = qbn(jj, 4);
    
        euler_angles(:, jj) = quatToEuler([q1, q2, q3, q4]);
    
    end

    figure
    grid on
    hold on
    plot(time, rad2deg(euler_angles(1,:)), 'LineWidth', 2)
    plot(time, rad2deg(euler_angles(2,:)), 'LineWidth', 2)
    plot(time, rad2deg(euler_angles(3,:)), 'LineWidth', 2)
    xlabel("Time (s)", 'Interpreter','latex', "FontSize", 25)
    ylabel("Euler Angles [deg]", 'Interpreter','latex', "FontSize", 25)
    legend("Roll", "Pitch", "Yaw", "Location", "best")


end