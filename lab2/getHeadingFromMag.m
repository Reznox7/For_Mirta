function heading = getHeadingFromMag(mag, roll, pitch)
    % Calculate heading angle from the current magnetometer
    % measurement and estimates of the roll and pitch

    % <YOUR CODE GOES HERE>
    numerator = -mag(2) * cos(roll) + mag(3) * sin(roll)
    denominator = mag(1)*cos(pitch) + mag(2)*sin(roll)*sin(pitch) + mag(3)*cos(roll)*sin(pitch)

    heading = atan(numerator/denominator);
end

