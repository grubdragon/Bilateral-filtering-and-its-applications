function[e_im] = erode(mask, se)

[r,c] = size(mask);
e_im = zeros(size(mask));

[w_se,h_se] = size(se);
s_w = (w_se-1)/2;
s_h = (h_se-1)/2;

for i=2:r-1
    for j=2:c-1
        if mask(i,j)==1
            k = mask(i-s_w : i+s_w, j-s_h : j+s_h) .* se / sum(se(:));
            if sum(k(:))==1
                e_im(i, j)=1;
            end
        end
    end
end

end