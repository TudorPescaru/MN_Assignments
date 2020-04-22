function B = PR_Inv(A)
	% Functia care calculeaza inversa matricii A folosind factorizari Gram-Schmidt
	% Algoritmul foloseste factorizarea Gram-Schmidt pentru a obtine Q si R si 
  % se foloseste de acestea si matricea identitate pentru a determina inversa
  n = size(A, 1);
  % Initializam cu 0 matricile si initializam matricea identitate
  R = zeros(n, n);
  Q = zeros(n, n);
  I = eye(n);
  B = zeros(n, n);
  % Obtinem Q si R folosind factorizare Gram-Schmidt modificata pentru stablitate 
  for i = 1:n
    R(i, i) = norm(A(:, i));
    Q(:, i) = A(:, i) / R(i, i);
    for j = i+1:n
      R(i, j) = Q(:, i)' * A(:, j);
      A(:, j) = A(:, j) - Q(:, i) * R(i, j);
    endfor
  endfor
  % Folosim algoritm de tip SST pentru a determina fiecare coloana din inversa
  for i = 1:n
    B(:, i) = SST(R, Q' * I(:, i));
  endfor
endfunction