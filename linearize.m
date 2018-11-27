function[im_amb_lin] = linearize(im_amb_lin_, ISO_f, ISO_a, dt_f, dt_a)
im_amb_lin = im_amb_lin_ * (ISO_f * dt_f)/(ISO_a * dt_a);
end