function [percentage] = evaluate(path_to_testset, w, histogram, count_bins)
  % build paths to testset of cat and non-cat images
  cats = "cats/";
  not_cats = "not_cats/";
  cats_path = strcat(path_to_testset, cats);
  not_cats_path = strcat(path_to_testset, not_cats);
  cats_dir = strcat(cats_path, '*.jpg');
  not_cats_dir = strcat(not_cats_path, '*.jpg');
  % get all testset images
  cats_files = dir(cats_dir);
  not_cats_files = dir(not_cats_dir);
  total = length(cats_files) + length(not_cats_files);
  % get percentage increments based on nr of images
  percentage = 0;
  p = 100 / total;
  % check cat images
  for i = 1:length(cats_files)
    % get path to image
    file_path = strcat(cats_path, cats_files(i).name);
    % get image histogram
    if strcmp(histogram, "RGB") == 1
      x = rgbHistogram(file_path, count_bins);
    else
      x = hsvHistogram(file_path, count_bins);
    endif
    % add bias element to histogram
    x(1, 3 * count_bins + 1) = 1;
    % scale non-bias elements
    x(1:3*count_bins) = x(1:3*count_bins) - mean(x(1:3*count_bins));
    x(1:3*count_bins) = x(1:3*count_bins) ./ std(x(1:3*count_bins));
    % get class and check if class is corect
    class = w' * x';
    if class >= 0
      percentage = percentage + p;
    endif
  endfor
  % check not cat images
  for i = 1:length(not_cats_files)
    % get path to image
    file_path = strcat(not_cats_path, not_cats_files(i).name);
    % get image histogram
    if strcmp(histogram, "RGB") == 1
      x = rgbHistogram(file_path, count_bins);
    else
      x = hsvHistogram(file_path, count_bins);
    endif
    % add bias element to histogram
    x(1, 3 * count_bins + 1) = 1;
    % scale non-bias elements
    x(1:3*count_bins) = x(1:3*count_bins) - mean(x(1:3*count_bins));
    x(1:3*count_bins) = x(1:3*count_bins) ./ std(x(1:3*count_bins));
    % get class and check if class is corect
    class = w' * x';
    if class < 0
      percentage = percentage + p;
    endif
  endfor
  % scale percentage to [0,1]
  percentage = percentage / 100;
endfunction