function [theta, J] = gradientDescent(X, y, theta, alpha, m, num_iters, calcCost = true)

  J = [];

  for iter = 1:num_iters
    errors = (X * theta - y);
    grad = (1/m * (X' * errors));
    theta = theta - alpha * grad;

    if (calcCost)
      J = [iter costFunction(X, y, theta); J];
    end
  end

end
