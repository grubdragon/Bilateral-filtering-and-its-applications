function[d_im] = dilate(mask, se)

[r,c] = size(mask);

[w_se,h_se] = size(se);
s_w = (w_se-1)/2;
s_h = (h_se-1)/2;

mask_padded = padarray(mask,[s_w s_h],0,'both');

for i=1:r
    for j=1:c
        if mask(i,j)==1
            mask_padded(i+s_w-1 : i+3*s_w-1, j+s_h-1 : j+3*s_h-1) = mask_padded(i+s_w-1 : i+3*s_w-1, j+s_h-1 : j+3*s_h-1) + se;
        end
    end
end

d_im = mask_padded(1+s_w:r+s_w, 1+s_h:r+s_h)>0;
end