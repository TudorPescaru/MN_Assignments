function [A, b] = generate_probabilities_system(rows)
  % Generate matrix and column vector for liniar equation system
  n_eq = (rows*(rows+1))/2;
  A = zeros(n_eq,n_eq);
  b = zeros(n_eq, 1);
  for i = n_eq-rows+1:n_eq
    b(i,1) = 1;
  endfor
  row_nr = 0;
  for i = 1:rows % row
    for j = row_nr+1:i*(i+1)/2 % nodes on row
      for k = 1:n_eq
        % check if diag
        if k == j
          %check if edge
          if (i == 1) || (i == rows)
            %check if corner
            if (j == row_nr+1) || (j == i*(i+1)/2)        
              A(j,k) = 4;
            else
              A(j,k) = 5;
            endif
          elseif (j == row_nr+1) || (j == i*(i+1)/2)
            A(j,k) = 5;
          else 
            A(j,k) = 6;
          endif
        endif
        % check if top row
        if i == 1
          % next row
          if (k == j+i) || (k == j+i+1)
            A(j,k) = -1;
          endif
        % check if bottom row
        elseif i == rows
          % same row
          if (j == row_nr+1) && (k == j+1)
            A(j,k) = -1;
          elseif (j == i*(i+1)/2) && (k == j-1)
            A(j,k) = -1;
          elseif (j > row_nr+1) && (j < i*(i+1)/2) && ((k == j-1) || (k == j+1))
            A(j,k) = -1;
          endif
          % upper row
          if (j == row_nr+1) && (k == j-i+1)
            A(j,k) = -1;
          elseif (j == i*(i+1)/2) && (k == j-i)
            A(j,k) = -1;
          elseif (j > row_nr+1) && (j < i*(i+1)/2) && ((k == j-i) || (k == j-i+1))
            A(j,k) = -1;
          endif
        else % middle rows
          % next row
          if (k == j+i) || (k == j+i+1)
            A(j,k) = -1;
          endif
          % same row
          if (j == row_nr+1) && (k == j+1)
            A(j,k) = -1;
          elseif (j == i*(i+1)/2) && (k == j-1)
            A(j,k) = -1;
          elseif (j > row_nr+1) && (j < i*(i+1)/2) && ((k == j-1) || (k == j+1))
            A(j,k) = -1;
          endif
          % upper row
          if (j == row_nr+1) && (k == j-i+1)
            A(j,k) = -1;
          elseif (j == i*(i+1)/2) && (k == j-i)
            A(j,k) = -1;
          elseif (j > row_nr+1) && (j < i*(i+1)/2) && ((k == j-i) || (k == j-i+1))
            A(j,k) = -1;
          endif
        endif
      endfor
    endfor
    row_nr = row_nr + i;
  endfor  
endfunction