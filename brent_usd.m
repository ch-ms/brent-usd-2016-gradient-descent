% Bent usd dataset logistic regression
% brent -> usd

isNormalize = true;
isQuadratic = false;
calcCost = false; %isNormalize;

% READ
data = readCSV("./brent_usd.csv");
data = unique(data, 'rows');
brent = data(:, 1);
usd = data(:, 2);

% PLOT
disp("Data visualization.");
visualize(brent, usd);
anykey();


% LEARNING

disp("\n");
printf("isNormalize=%i isQuadratic=%i Learning...\n\n", isNormalize, isQuadratic);
% Init
prediction_points = [0; 20; 25; 60; 65; 100];
y = usd;
X = brent;
X_predictions = prediction_points;
m = length(y);

if (isNormalize)
  [X, mu, sigma] = normalize(X);
  X_predictions = (X_predictions - mu) ./ sigma;
  alpha = 0.001;
  iterations = 50000;
else
  alpha = 0.0001;
  iterations = 1200000;
end

if (isQuadratic)
  X = [X (X .^ 2)];
  X_predictions = [X_predictions (X_predictions .^ 2)];
end

X = [ones(m, 1), X];
X_predictions = [ones(size(X_predictions, 1), 1) X_predictions];

init_theta = zeros(size(X)(2), 1);

% Descent
[theta, J, tstart, tend, ttotal] = learn(X, y, init_theta, alpha, m, iterations, calcCost);


% STATISTICS
disp("Statistics.");
printf("Learning time: %i\n", ttotal);

if (isQuadratic)
  printf("Learned: %i %i %i \n", theta);
else
  printf("Learned: %i %i\n", theta);
end

printf("Initial cost: %i\n", costFunction(X, y, init_theta));
printf("Cost after learning: %i\n", costFunction(X, y, theta));
printf("\n\n");


% VISUALIZE

disp("Model visualization.\n")
visualize(brent, usd);
hold on;
% Hypothesis
plot(brent, X * theta, "-");
anykey();

% Predictions
disp("Predictions.\n")
plot(prediction_points, X_predictions * theta, "x");
hold off;
anykey();

% Cost function changes
if (calcCost)
  disp("Cost function changes visualization.\n")
  plot(J(:, 1), J(:, 2));
  anykey();
end

% Cost function
if (!isQuadratic)
  disp("Cost function visualization.\n");

  l = 50;
  r1 = 5 * 3;
  r2 = 5 * 3;
  theta0_vals = linspace(theta(1) - r1, theta(1) + r1, l);
  theta1_vals = linspace(theta(2) - r2, theta(2) + r2, l);
  J_vals = zeros(l, l);

  for i = 1:l
    for j = 1:l
      t = [theta0_vals(i); theta1_vals(j)];
      J_vals(i, j) = costFunction(X, y, t);
    end
  end

  figure;
  surf(theta0_vals, theta1_vals, J_vals);
  xlabel('\theta_0'); ylabel('\theta_1');
  anykey();

end
