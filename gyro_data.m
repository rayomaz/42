% Extract gyroscope data
function [wn, trueRate, Bias, Angle, measRate, AC_wbn] = gyro_data(Gyro)
    wn = Gyro(:, 1:3);
    trueRate = Gyro(:, 4:6);
    Bias = Gyro(:, 7:9);
    Angle = Gyro(:, 10:12);
    measRate = Gyro(:, 13:15);
    AC_wbn = Gyro(:, 16:18);
end