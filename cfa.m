function[F_adj] = cfa(im_amb, im_flash, alpha)

im_amb_y = rgb2ycbcr(im_amb);
im_flash_y = rgb2ycbcr(im_flash);

F_adj_y = alpha * im_flash_y + (1-alpha) * im_amb_y;
F_adj = ycbcr2rgb(F_adj_y);

end