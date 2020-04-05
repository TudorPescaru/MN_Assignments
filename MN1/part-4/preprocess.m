function [X, y] = preprocess(path_to_dataset, histogram, count_bins)
  % build paths to datasets of cat and non-cat images
  cats = "cats/";
  not_cats = "not_cats/";
  cats_path = strcat(path_to_dataset, cats);
  not_cats_path = strcat(path_to_dataset, not_cats);
  cats_dir = strcat(cats_path, '*.jpg');
  not_cats_dir = strcat(not_cats_path, '*jpg');
  % get all dataset images
  cats_files = dir(cats_dir);
  not_cats_files = dir(not_cats_dir);
  total = length(cats_files) + length(not_cats_files);
  % initialise X and y
  X = zeros(total, 3 * count_bins);
  y = zeros(total, 1);
  % fill X and y with data for cat images
  for i = 1:length(cats_files)
    file_path = strcat(cats_path, cats_files(i).name);
    if strcmp(histogram, "RGB") == 1
      sol = rgbHistogram(file_path, count_bins);
    else
      sol = hsvHistogram(file_path, count_bins);
    endif
    X(i, :) = sol;
    y(i) = 1;
  endfor
  % fill X and y with data for non-cat images
  for i = length(cats_files) + 1:total
    file_path = strcat(not_cats_path, not_cats_files(i - length(cats_files)).name);
    if strcmp(histogram, "RGB") == 1
      sol = rgbHistogram(file_path, count_bins);
    else
      sol = hsvHistogram(file_path, count_bins);
    endif
    X(i, :) = sol;
    y(i) = -1;
  endfor
endfunction