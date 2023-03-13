function err = accError(x, inputs)
% Given the vector of parameters x = [x1, x2, x3, x4, x5, x6, x7, x8, x9]
% and the list of acceleration measurements, calculate the mean squared
% error of the sensor model and gravity acceleration constant. You may
% assume that g = 9.80665

% <YOUR CODE GOES HERE>
 A = [x(1), x(2), x(3); x(2), x(4), x(5); x(3),x(5),x(6)];
 b = [x(7); x(8); x(9)];
 err = 0;
 g = 9.80665;
 for i = 1:length(inputs)
    temp = A * (inputs(i,:)-b)';
    err = err + (norm(temp) - g)^2;
 end

 %err = err *(1 / size(inputs,1));
 end
