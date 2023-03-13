function [roll, pitch] = getRollPichFromAcceleration(a)
    % Calculate roll and pitch angles from the current acceleration
    % measurement

    % <YOUR CODE GOES HERE>
    roll = atan(a(2) / a(3));
    pitch = atan(a(1) / (-sign(a(3)) * sqrt(a(2).^2 + 0.01*a(3).^2)));

end

