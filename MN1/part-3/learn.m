function [w] = learn (X, y)
  [n, m] = size (X);
  ## build X_tilda
  X_tilda = X;
  ## add bias element column as last column of X_tilda
  X_tilda(:, m+1) = 1;
  ## get Q, R using Householder
  [Q, R] = Householder (X_tilda);
  ## get trained model using SST
  w = SST (R, Q' * y);
endfunction