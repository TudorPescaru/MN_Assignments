function [cost] = compute_cost_pc(points, centroids)
  % get number of points and centroids
  N = size(points, 1);
  NC = size(centroids, 1);
  cost = 0;
  % for each point
  for i = 1:N
    % find minimum distance to a centroid
    mini = norm(centroids(1, :) - points(i, :));
    for j = 1:NC
      dist = norm(centroids(j, :) - points(i, :));
      if dist < mini
        mini = dist;
      endif
    endfor
    cost = cost + mini;
  endfor
endfunction

