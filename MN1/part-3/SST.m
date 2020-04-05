function [x] = SST(A, b)
  % check if matrix A is upper triangular
  if max(max(abs(tril(A, -1)))) > 10^3 * eps
    x = NaN;
    return;
  endif
  % calculate solution vector from back to front
  [n, m] = size(A);
  % solution vector will have size = nr of columns in A
  % this is done to accommodate non-square matrices
  x = zeros(m, 1);
  % calculate last element first
  x(m, 1) = b(m, 1) / A(m, m);
  % itteratively calculate new elements based on previous ones
  for k = (m - 1):-1:1
    sigma = A(k, ((k + 1) : m)) * x(((k + 1) : m), 1);
    x(k, 1) = (b(k, 1) - sigma) / A(k, k);
  endfor
end 