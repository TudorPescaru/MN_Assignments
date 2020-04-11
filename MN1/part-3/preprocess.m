function [X, y] = preprocess (path_to_dataset, histogram, count_bins)
  ## get matrix of image names in dataset
  cats_path = strcat (path_to_dataset, "cats/");
  not_cats_path = strcat (path_to_dataset, "not_cats/");
  cats_imgs = getImgNames (cats_path);
  not_cats_imgs = getImgNames (not_cats_path);
  [n, m] = size (cats_imgs);
  [p, q] = size (not_cats_imgs);
  total = n + p;
  ## initialise X and y
  X = zeros (total, 3 * count_bins);
  y = zeros (total, 1);
  ## fill X and y with data for cat images
  for i = 1:n
    img_path = strcat (cats_path, cats_imgs(i, :));
    if strcmp (histogram, "RGB") == 1
      sol = rgbHistogram (img_path, count_bins);
    else
      sol = hsvHistogram (img_path, count_bins);
    endif
    X(i, :) = sol;
    y(i) = 1;
  endfor
  ## fill X and y with data for non-cat images
  for i = n+1:total
    img_path = strcat (not_cats_path, not_cats_imgs(i-n, :));
    if strcmp (histogram, "RGB") == 1
      sol = rgbHistogram (img_path, count_bins);
    else
      sol = hsvHistogram (img_path, count_bins);
    endif
    X(i, :) = sol;
    y(i) = -1;
  endfor
endfunction