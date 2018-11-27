function[wb_im] = wb_rgb(im_amb_lin, im_flash_lin, im_amb, tau1, tau2, se)
wb_im(:,:,1) = white_balance(im_amb_lin(:,:,1), im_flash_lin(:,:,1), im_amb(:,:,1), tau1, tau2, se);
wb_im(:,:,2) = white_balance(im_amb_lin(:,:,2), im_flash_lin(:,:,1), im_amb(:,:,2), tau1, tau2, se);
wb_im(:,:,3) = white_balance(im_amb_lin(:,:,3), im_flash_lin(:,:,1), im_amb(:,:,3), tau1, tau2, se);
end