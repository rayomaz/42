%% Calling 42 C code through Matlab interface
% Rayan Mazouz, Marco Quadrelli
% Verification: Orbits and Attitude

clc; clear; close all;

%% Call 42
spacecraft_type = 'Sphere'; %'Custom'; 
% output = system(['./42 Custom/', spacecraft_type]);
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

%% Plots
plot_spacecraft_data(time, ...
                     PosN, VelN, qbn, wbn, Hvb, wn, ...
                     EnvTrq00, spacecraft_type , false);




