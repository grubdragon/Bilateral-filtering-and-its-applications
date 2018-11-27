function[smooth_im] = bf_rgb(im, sigma_s, sigma_r, window_size)
smooth_im(:,:,1) = bilateral_filter(im(:,:,1), sigma_s, sigma_r, window_size);
smooth_im(:,:,2) = bilateral_filter(im(:,:,2), sigma_s, sigma_r, window_size);
smooth_im(:,:,3) = bilateral_filter(im(:,:,3), sigma_s, sigma_r, window_size);
end