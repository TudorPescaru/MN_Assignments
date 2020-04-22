function R = Iterative(nume, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	%	-> nume: numele fisierului din care se citeste;
	%	-> d: coeficentul d, adica probabilitatea ca un anumit navigator sa continue navigarea (0.85 in cele mai multe cazuri)
	%	-> eps: eruarea care apare in algoritm.
	% Iesiri:
	%	-> R: vectorul de PageRank-uri acordat pentru fiecare pagina. 
  % Construim matricea de adiacenta din fisier
  A = AdjMatrix(nume);
  % Obtinem numarul de pagini web
  N = size(A, 1);
  % Calculam matricea K, matrice diagonala cu numarul conexiunilor fiecarui nod
  % Se calculeaza direct K inversat deoarece este matrice diagonala
  K = diag(1 ./ sum(A'));
  M = (K * A)';
  % Se construieste vectorul coloana cu 1
  one = zeros(N, 1);
  one(1:N) = 1;
  % Se initializeaza R
  oldR = zeros(N, 1);
  oldR(1:N) = 1 / N;
  % Se itereaza si se calculeaza noul R pana cand eroarea este mai mica ca eps
  while 1
    R = d * M * oldR + ((1 - d) / N) * one;
    err = norm(R - oldR);
    if err < eps
      return;
    endif
    oldR = R;
  endwhile
endfunction