function [w] = learn(X, y, lr, epochs)
  [n, m] = size(X);
  X_tilda = X;
  % add bias element column
  X_tilda(:, m + 1) = 1;
  % scale non-bias columns
  for i = 1:n
    X_tilda(i, 1:m) = X_tilda(i, 1:m) - mean(X_tilda(i, 1:m));
    X_tilda(i, 1:m) = X_tilda(i, 1:m) ./ std(X_tilda(i, 1:m));
  endfor
  % generate initial w using random values in [-0.1, 0.1]
  lower_bound = -0.1;
  upper_bound = 0.1;
  w = lower_bound + (upper_bound - lower_bound) .* rand(m + 1, 1);
  % start learning for given nr of epochs
  for epoch = 1:epochs
    % select random lines from X_tilda and their y tags
    index_rand = randperm(n, 64);
    X_batch = X_tilda(index_rand, :);
    y_batch = y(index_rand, 1);
    % calculate all new values of w for this epoch
    for i = 1:m + 1
      sigma = sum((X_batch(1:64, :) * w - y_batch(1:64, 1)) .* X_batch(1:64, i));
      w(i) = w(i) - lr * (1 / n) * sigma;
    endfor
  endfor
endfunction