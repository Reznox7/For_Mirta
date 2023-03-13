function ang = getAnglesFromGyro(ang_vel, prev_ang, Ts)
    % From current angular velocity measurement and previous step angle
    % estimate, calculate the current step angle estimate

    % <YOUR CODE GOES HERE
    ang = prev_ang + ang_vel * Ts;
    
end

