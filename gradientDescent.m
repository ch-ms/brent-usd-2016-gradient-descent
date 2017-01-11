function [theta, J] = gradientDescent(X, y, theta, alpha, m, num_iters, calcCost = true)

  learning_rate = (alpha * 1/m);
  J = [];

  for iter = 1:num_iters
    errors = (X * theta - y);
    grad = (learning_rate * (X' * errors));
    theta = theta - grad;
    
    if (calcCost)
      J = [iter costFunction(X, y, theta); J];
    end
  end

end
