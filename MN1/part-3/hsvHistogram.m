function [sol] = hsvHistogram(path_to_image, count_bins)
  % read image data from path 
  rgb_image = imread(path_to_image);
  % convert rgb to hsv
  hsv_image = RGB2HSV(rgb_image);
  % separate hsv-coverted image into H, S and V matrices
  H = hsv_image(:, :, 1);
  S = hsv_image(:, :, 2);
  V = hsv_image(:, :, 3);
  % initialise sol vector and bin ranges
  sol = zeros(1, 3 * count_bins); 
  binrange = [0:(101 / count_bins):101];
  binrange = binrange / 100;
  % create histogram for hue
  counts = histc(H, binrange);
  counts = counts((1 : count_bins), :);
  sol(1:count_bins) = sum(counts');
  % create histogram for saturation
  counts = histc(S, binrange);
  counts = counts((1 : count_bins), :);
  sol((count_bins + 1):(2 * count_bins)) = sum(counts');
  % create histogram for value
  counts = histc(V, binrange);
  counts = counts((1 : count_bins), :);
  sol((2 * count_bins + 1):(3 * count_bins)) = sum(counts');
endfunction