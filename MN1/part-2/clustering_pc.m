function [centroids] = clustering_pc (points, NC)
  [N, D] = size (points);
  centroids = zeros (NC, D);
  ## initialize matrixes for point clusters
  sums = zeros (NC, D);
  count = zeros (NC, 1);
  ## populate sums and count matrixes
  for i = 1:N
    ## if mod = 0 then line is NC
    if mod (i, NC) == 0
      ## add point for all D dimensions
      for j = 1:D
        sums(NC, j) = sums(NC, j) + points(i, j);
      endfor
      ## count points found 
      count(NC, 1) = count(NC, 1) + 1;
    else
      ## line is i mod NC
      ## add point for all D dimensions
      for j = 1:D
        sums(mod (i, NC), j) = sums(mod (i, NC), j) + points(i, j);
      endfor
      ## count points found
      count(mod (i, NC), 1) = count(mod (i, NC), 1) + 1;
    endif
  endfor
  ## build centroids with avg
  for i = 1:NC
    if count(i, 1) != 0
      for j = 1:D
        centroids(i, j) = sums(i, j) / count(i, 1);
      endfor
    endif
  endfor
  ## initial pass through algorithm
  ## initialize point groups
  groups = zeros (NC, N);
  sums = zeros (NC, D);
  count = zeros (NC, 1);
  ## separate points into groups based on nearest centroid
  for i = 1:N
    mini = norm (centroids(1, :) - points(i, :));
    c = 1;
    for j = 1:NC
      dist = norm (centroids(j, :) - points(i, :));
      if dist < mini
        mini = dist;
        c = j;
      endif
    endfor
    groups(c, count(c, 1) + 1) = i;
    count(c, 1) = count(c, 1) + 1;
  endfor
  ## recalculate centroid based on grouped points
  for i = 1:NC
    for j = 1:count(i,1)
      for k = 1:D
        sums(i, k) = sums(i, k) + points(groups(i, j), k);
      endfor
    endfor
  endfor
  for i = 1:NC
    if count(i, 1) != 0
      for j = 1:D
        centroids(i, j) = sums(i, j) / count(i, 1);
      endfor
    endif
  endfor
  ok = 0;
  ## repeat algorithm until centroid positions stop changing
  while ok != 1
    ## store old centroid values
    old_centroids = centroids;
    ## initialize point groups
    groups = zeros (NC, N);
    sums = zeros (NC, D);
    count = zeros (NC, 1);
    ## separate points into groups based on nearest centroid
    for i = 1:N
      mini = norm (centroids(1, :) - points(i, :));
      c = 1;
      for j = 1:NC
        dist = norm (centroids(j, :) - points(i, :));
        if dist < mini
          mini = dist;
          c = j;
        endif
      endfor
      groups(c, count(c, 1) + 1) = i;
      count(c, 1) = count(c, 1) + 1;
    endfor
    ## recalculate centroid based on grouped points
    for i = 1:NC
      for j = 1:count(i,1)
        for k = 1:D
          sums(i, k) = sums(i, k) + points(groups(i, j), k);
        endfor
      endfor
    endfor
    for i = 1:NC
      if count(i, 1) != 0
        for j = 1:D
          centroids(i, j) = sums(i, j) / count(i, 1);
        endfor
      endif
    endfor
    ## determine if centroids changed position from old centroids
    dif = 1;
    for i = 1:NC
      dist = norm (centroids(i, :) - old_centroids(i, :));
      if dist !=0
        dif = 0;
        break;
      endif
    endfor
    ok = dif;
  endwhile
endfunction
