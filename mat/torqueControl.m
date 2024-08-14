%% Perform control analysis using magneto torquers
% Rayan Mazouz, Marco Quadrelli

clc; clear; close all;

%% Torque T = m x \beta


% Transform B from the inertial frame I to the body frame B

% Some attitude parameterization in q (JPL convention)
q = [0, 0, 0, 1];

% Obtain rotation matrix from I to N
R = rotation_matrix_I_to_B(q);



%% Functions
function R = rotation_matrix_I_to_B(quaternion)

    q1 = quaternion(1);
    q2 = quaternion(2);
    q3 = quaternion(3);
    q4 = quaternion(4);


    % Finish rotation matrix (use JPL convention)
    R = [q1, q2, q3, q4]; ...


end
