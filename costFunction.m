function J = costFunction(X, y, theta)

  m = length(y);

  error_rate = (X * theta - y).^2;
  J = 1/(2*m) * sum(error_rate);

end
