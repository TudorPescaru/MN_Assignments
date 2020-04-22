function [A, val1, val2] = AdjMatrix(nume)
  % Functia care construieste matricea de adiacenta a unui graf dintr-un fisier nume
  % Functia returneaza, de asemenea, val1 si val2
  % Deschide fisierul pentru citire
  graphFile = fopen(nume, 'r');
  % Citeste numarul de noduri ale grafului
  nodes = fscanf(graphFile, '%d', [1, 1]);
  A = zeros(nodes, nodes);
  % Completarea matricei de adiacenta
  for line = 1:nodes
    % Cititrea nodului corespunzator listei de adiacenta
    index = fscanf(graphFile, '%d', [1, 1]);
    % Citirea numarului de noduri din lista de adiacenta
    count = fscanf(graphFile, '%d', [1, 1]);
    % Citirea listei de adiacenta si marcarea pozitiilor cu 1 in matricea de adiacenta
    neighbors = fscanf(graphFile, '%d', [1, count]);
    A(index, neighbors) = 1;
    A(index, index) = 0;
  endfor
  % Citire val1 si val2 
  val1 = fscanf(graphFile, '%f', [1, 1]);
  val2 = fscanf(graphFile, '%f', [1, 1]);
  fclose(graphFile);
endfunction