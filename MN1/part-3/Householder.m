function [Q, R] = Householder (A)
  [m, n] = size (A);
  ## initailise q
  Q = eye (m);
  for p = 1:min ((m - 1), n)
    ## calculate V_p column vector for each column in A
    V_p = zeros (m, 1);
    V_p((p + 1) : m) = A(((p + 1) : m), p);
    sigma_p = sign (A(p, p)) * norm (A((p : m), p));
    V_p(p) = A(p, p) + sigma_p;
    ## calculate Householder reflector
    H_p = eye (m) - 2 * (V_p * V_p') / (V_p' * V_p);
    ## calculate new A as old A * reflector
    beta_p = sigma_p * V_p(p);
    A(p, p) = -sigma_p;
    A(((p + 1) : m), p) = 0;
    ## product is done like this to support non square matrixes
    for j = p+1:n
      tau_j = 0;
      for i = p:m
        tau_j = tau_j + (V_p(i) * A(i, j));
      endfor
      tau_j = tau_j / beta_p;
      A((p : m), j) = A((p : m), j) - tau_j * V_p(p : m);
    endfor
    ## calculate new Q as reflector * old Q
    Q = H_p * Q;
  endfor
  ## R is the last A which is upper triangular
  R = A;
  ## Q is transpose of product of all reflectors
  Q = Q';
endfunction