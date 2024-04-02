function eulerAngles = quatToEuler(quaternion)
    % Quaternion to Euler conversion using specified convention
    % Inputs:
    %   - quaternion: 1x4 array representing the quaternion [q1, q2, q3, q4]
    % Output:
    %   - eulerAngles: 1x3 array of Euler angles [roll, pitch, yaw] in radians
    
    q1 = quaternion(1);
    q2 = quaternion(2);
    q3 = quaternion(3);
    q4 = quaternion(4);

    % Calculate roll (phi)
    roll = atan2(2 * (q4*q1 + q2*q3), 1 - 2 * (q1^2 + q2^2));
    
    % Calculate pitch (theta)
    pitch = asin(2 * (q4*q2 - q3*q1));
    
    % Calculate yaw (psi)
    yaw = atan2(2 * (q4*q3 + q1*q2), 1 - 2 * (q2^2 + q3^2));
    
    eulerAngles = [roll, pitch, yaw];
end
