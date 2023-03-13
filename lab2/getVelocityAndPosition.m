function [acc, vel, pos] = getVelocityAndPosition(a, R, prev_vel, prev_pos, Ts)
    % From current acceleration measurement, first subtract gravity
    % acceleration which is dependent on the current orientation R. Then
    % use previous step estimates of velocity and position and calculate
    % current step acceleration, velocity and position
    % You may assume that g = 9.80665
    
    % <YOUR CODE GOES HERE>
    
    acc = a' - R * [0;0;9.80665];
    vel = prev_vel' + acc * Ts;
    pos = prev_pos' + vel * Ts/2;
end

