function [theta, J, tstart, tend, ttotal] = learn(X, y, init_theta, alpha, m, iterations, calcCost = true)

  tstart = time();
  [theta, J] = gradientDescent(X, y, init_theta, alpha, m, iterations, calcCost);
  tend = time();
  ttotal = tend - tstart;

end
