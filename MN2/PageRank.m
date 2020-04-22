function [R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
  % Construieste numele fisierului si il deschide pentru scriere
  fileName = strcat(nume, ".out");
  outFile = fopen(fileName, 'w');
  % Parseaza fisierul care contine graful
  [A, val1, val2] = AdjMatrix(nume);
  % Scrie numarul de pagini analizate in fisier
  N = size(A, 1);
  fprintf(outFile, '%d\n\n', N);
  % Construieste vectorul PageRank cu primul algoritm si il scrie in fisier
  R1 = Iterative(nume, d, eps);
  fprintf(outFile, '%f\n', R1);
  fprintf(outFile, '\n');
  % Construieste vectorul PageRank cu al doilea algoritm si il scrie in fisier
  R2 = Algebraic(nume, d, eps);
  fprintf(outFile, '%f\n', R2);
  fprintf(outFile, '\n');
  % Construieste oridnea celor mai importante pagini si o scrie in fisier
  [PR1, J] = sort(R2, 'descend');
  for i = 1:N
    fprintf(outFile, '%d %d %f\n', i, J(i), Apartenenta(PR1(i), val1, val2));
  endfor
  fclose(outFile);
endfunction