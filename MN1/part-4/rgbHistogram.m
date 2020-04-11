function [sol] = rgbHistogram (path_to_image, count_bins)
  ## read image data from path 
  image = imread (path_to_image);
  ## separate pixels into rgb matrixes
  R = image(:, :, 1);
  G = image(:, :, 2);
  B = image(:, :, 3);
  ## initialise sol vector and bin ranges
  sol = zeros (1, 3 * count_bins); 
  binrange = [0:(256 / count_bins):256];
  ## create histogram for red
  counts = histc (R, binrange);
  counts = counts((1 : count_bins), :);
  sol(1:count_bins) = sum (counts');
  ## create histogram for green
  counts = histc (G, binrange);
  counts = counts((1 : count_bins), :);
  sol((count_bins + 1):(2 * count_bins)) = sum (counts');
  ## create histogram for blue
  counts = histc (B, binrange);
  counts = counts((1 : count_bins), :);
  sol((2 * count_bins + 1):(3 * count_bins)) = sum (counts');
endfunction