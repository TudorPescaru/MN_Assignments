function [percentage] = evaluate (path_to_testset, w, histogram, count_bins)
  ## get matrix of image names in testset
  cats_path = strcat (path_to_testset, "cats/");
  not_cats_path = strcat (path_to_testset, "not_cats/");
  cats_imgs = getImgNames (cats_path);
  not_cats_imgs = getImgNames (not_cats_path);
  [n, m] = size (cats_imgs);
  [p, q] = size (not_cats_imgs);
  total = n + p;
  ## get percentage increments based on nr of images
  percentage = 0;
  p_inc = 100 / total;
  ## check cat images
  for i = 1:n
    ## get path to image
    img_path = strcat (cats_path, cats_imgs(i, :));
    ## get image histogram
    if strcmp (histogram, "RGB") == 1
      x = rgbHistogram (img_path, count_bins);
    else
      x = hsvHistogram (img_path, count_bins);
    endif
    ## add bias element to histogram
    x(1, 3 * count_bins + 1) = 1;
    ## scale non-bias elements
    x(1:3*count_bins) = x(1:3*count_bins) - mean (x(1:3*count_bins));
    x(1:3*count_bins) = x(1:3*count_bins) ./ std (x(1:3*count_bins));
    ## get class and check if class is corect
    class = w' * x';
    if class >= 0
      percentage = percentage + p_inc;
    endif
  endfor
  ## check not cat images
  for i = 1:p
    ## get path to image
    img_path = strcat (not_cats_path, not_cats_imgs(i, :));
    ## get image histogram
    if strcmp(histogram, "RGB") == 1
      x = rgbHistogram (img_path, count_bins);
    else
      x = hsvHistogram (img_path, count_bins);
    endif
    ## add bias element to histogram
    x(1, 3 * count_bins + 1) = 1;
    ## scale non-bias elements
    x(1:3*count_bins) = x(1:3*count_bins) - mean (x(1:3*count_bins));
    x(1:3*count_bins) = x(1:3*count_bins) ./ std (x(1:3*count_bins));
    ## get class and check if class is corect
    class = w' * x';
    if class < 0
      percentage = percentage + p_inc;
    endif
  endfor
  ## scale percentage to [0,1]
  percentage = percentage / 100;
endfunction