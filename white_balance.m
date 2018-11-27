function[A_wb] = white_balance(im_amb_lin, im_flash_lin, im_amb, tau1, tau2, se)

if se == []
    se = [0, 1, 0;1, 1, 1; 0, 1, 0];
end

K1 = im_amb(:);
min_r_amb = min(K1);
max_r_amb = max(K1);
m1 = (im_amb - min_r_amb) >= (tau1/100) * (max_r_amb - min_r_amb);

del_p = (im_flash_lin - im_amb_lin);
K2 = del_p(:);
min_r_del = min(K2);
max_r_del = max(K2);
m2 = (del_p - min_r_del) >= (tau2/100) * (max_r_del - min_r_del);

m = m1+m2==2;

Cp = (del_p ./ im_amb) .* m;
c = sum(Cp(:))/sum(m(:))

A_wb = im_amb/c;

end