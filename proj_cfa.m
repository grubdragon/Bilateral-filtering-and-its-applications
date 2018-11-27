im_amb = im2double(imread('A2.png'));
im_flash = im2double(imread('F.png'));

cfa_res = cfa(im_amb, im_flash, 0.45);
imshow(cfa_res)