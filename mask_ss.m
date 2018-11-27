function[mask_ss] = mask_ss(im_amb_lin, im_flash_lin, tau_shad, se)

if se == []
    se = [0, 1, 0;1, 1, 1; 0, 1, 0];
end

mask_shad_temp = (im_flash_lin - im_amb_lin)<=tau_shad;
mask_shad = imerode(mask_shad_temp,se);
mask_shad = imfill(mask_shad,'holes');
mask_shad = imdilate(mask_shad,se);

K = im_flash_lin(:);
min_r = min(K);
max_r = max(K);
mask_spec_temp = (im_flash_lin - min_r) >= 0.95 * (max_r-min_r);
mask_spec = imerode(mask_spec_temp,se);
mask_spec = imfill(mask_spec,'holes');
mask_spec = imdilate(mask_spec,se);

mask_ss_temp = (mask_spec + mask_shad)>0;
sigma = 1;
s = 1;
[x, y]=meshgrid(-s:s,-s:s);
kernel = exp(-(x.^2+y.^2)/(2*sigma^2));  
kernel = kernel/sum(kernel(:));
mask_ss = conv2(mask_ss_temp,kernel,'same');

end