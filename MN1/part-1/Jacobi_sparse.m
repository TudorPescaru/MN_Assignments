function [x] = Jacobi_sparse(G_values, G_colind, G_rowptr, c, tol)
  % Function that computest solution vector from 
  % Jacobi iteration matrix and vector
  n = size(c,1);
  old_x = zeros(n,1);
  while 1
    x = csr_multiplication(G_values, G_colind, G_rowptr, old_x) + c;
    diff = norm(x - old_x);
    if diff < tol
      return;
    endif
    old_x = x;
  endwhile
endfunction