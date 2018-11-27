im_amb = im2double(imread('A2.png'));
im_flash = im2double(imread('F.png'));

figure, imshow(im_amb)
figure, imshow(im_flash)

A_wb = wb_rgb(im_amb, im_flash, im_amb, 2, 2, []);
imshow(A_wb)