function[smooth_im] = bilateral_filter_joint(im_amb, im_flash, sigma_s, sigma_r, window_size)
[dist_x, dist_y]=meshgrid(-window_size:window_size,-window_size:window_size);
g_d=exp(-(dist_x.^2+dist_y.^2)/(2*sigma_s^2));  

[rows, cols] = size(im_amb);
smooth_im = zeros(size(im_amb));

done = 0;
for i=1:rows
    parfor j=1:cols
        r_min = max(1,i-window_size);
        r_max = min(rows,i+window_size);
        c_min = max(1,j-window_size);
        c_max = min(cols,j+window_size);
        
        A = im_amb(r_min : r_max, c_min : c_max);
        F = im_flash(r_min : r_max, c_min : c_max);
        g_r = exp(-(F - im_flash(i,j)).^2/(2*sigma_r^2));
        
        bi_filt = g_r.*g_d(-i + (r_min:r_max) + window_size + 1, -j + (c_min:c_max) + window_size + 1);
        bi_filt_norm = sum(bi_filt(:));
        
        smooth_im(i,j) = sum(sum(bi_filt.*A))/bi_filt_norm;
    end
    clc;
    disp(done/rows)
    done = done +1
end
end