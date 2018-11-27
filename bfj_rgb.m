function[smooth_im] = bfj_rgb(im_amb, im_flash, sigma_s, sigma_r, window_size)
smooth_im(:,:,1) = bilateral_filter_joint(im_amb(:,:,1), im_flash(:,:,1), sigma_s, sigma_r, window_size);
smooth_im(:,:,2) = bilateral_filter_joint(im_amb(:,:,2), im_flash(:,:,1), sigma_s, sigma_r, window_size);
smooth_im(:,:,3) = bilateral_filter_joint(im_amb(:,:,3), im_flash(:,:,1), sigma_s, sigma_r, window_size);
end