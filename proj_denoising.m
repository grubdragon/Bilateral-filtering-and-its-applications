im_amb = im2double(imread('A2.png'));
im_flash = im2double(imread('F.png'));

A_base = bf_rgb(im_amb, 1, 0.1, 5);
A_nr = bfj_rgb(im_amb, im_flash, 1, 0.1, 5);

M = mss_rgb(im_amb,im_flash,5,[]);
A_nr_ = (1 - M) .* A_nr + M .* A_base;

imshow(A_nr);
imshow(A_nr_);