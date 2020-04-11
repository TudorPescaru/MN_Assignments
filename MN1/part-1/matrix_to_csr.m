function [values, colind, rowptr] = matrix_to_csr(A)
  ## Function that converts a sparse matrix to CSR format
  [colind, rows, values] = find (A.');
  n = size (A, 1);
  nz = size (values, 1);
  j = 2;
  rowptr(1) = 1;
  for i = 2:nz
    if rows(i) != rows(i-1)
      rowptr(j) = i;
      j = j + 1;
    endif
  endfor
  rowptr(j) = nz + 1;
  colind = colind.';
  values = values.';
endfunction