function[mss] = mss_rgb(im_amb,im_flash,tau_shad, se)
mss(:,:,1) = mask_ss(im_amb(:,:,1), im_flash(:,:,1), tau_shad, se);
mss(:,:,2) = mask_ss(im_amb(:,:,2), im_flash(:,:,1), tau_shad, se);
mss(:,:,3) = mask_ss(im_amb(:,:,3), im_flash(:,:,1), tau_shad, se);
end