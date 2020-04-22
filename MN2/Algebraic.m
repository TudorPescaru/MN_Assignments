function R = Algebraic(nume, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de calcul.
	% Intrari: 
	%	-> nume: numele fisierului in care se scrie;
	%	-> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina urmatoare.
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
  % Se initializeaza matricea identitate
  I = eye(N);
  % Se calculeaza R algebric
  R = PR_Inv(I - d * M) * ((1 - d) / N) * one;
endfunction