function [HSV] = RGB2HSV (RGB)
  ## initialise HSV multidimensional matix
  [n, m, p] = size (RGB);
  HSV = zeros (n, m, p);
  ## convert RGB to [0,1]
  RGB_p = double (RGB) / double (255);
  ## build matrix of maximum value from R, G and B matrices
  [C_max, max_val] = max (RGB_p, [], 3);
  ## build matrix of minimum value from R, G and B matrices
  C_min = min (RGB_p, [], 3);
  delta = C_max - C_min;
  ## calculate H matrix
  if nnz (delta) ~= 0
    ## initialise template matrix
    H = zeros (n, m);
    ## get vectors of liniar indices for the three cases
    F1 = find (max_val == 1)';
    F2 = find (max_val == 2)';
    F3 = find (max_val == 3)';
    ## build the H value matrices for each of the three cases
    H1 = 60 * mod ((RGB_p(:, :, 2) - RGB_p(:, :, 3)) ./ delta, 6);
    H2 = 60 * (((RGB_p(:, :, 3) - RGB_p(:, :, 1)) ./ delta) + 2);
    H3 = 60 * (((RGB_p(:, :, 1) - RGB_p(:, :, 2)) ./ delta) + 4);
    ## assemble template matrix
    H(F1) = H1(F1);
    H(F2) = H2(F2);
    H(F3) = H3(F3);
    ## copy template matrix into multidimensional matrix
    HSV(:, :, 1) = H;
  endif
  HSV(:, :, 1) = HSV(:, :, 1) / 360;
  ## calculate S matrix
  if nnz (C_max) ~= 0
    HSV(:, :, 2) = delta ./ C_max;
  endif
  ## calculate V matrix
  HSV(:, :, 3) = C_max;
  ## at the end HSV matrices are in [0,1]
endfunction