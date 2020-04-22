function [x] = SST(A, b)
  % Verificare daca matricea A este superior triunghiulara
  if istriu(A) == 0
    x = NaN;
    return;
  endif
  n = size(A, 1);
  x = zeros(n, 1);
  % Calculam mai intai ultimul element
  x(n, 1) = b(n, 1) / A(n, n);
  % Calculam iterativ urmatoarele elemente in functie de cele calculate anterior
  for k = (n - 1):-1:1
    sigma = A(k, ((k + 1) : n)) * x(((k + 1) : n), 1);
    x(k, 1) = (b(k, 1) - sigma) / A(k, k);
  endfor
end 