clc;
clear all;
close all;
im = imread('landscape.jpg');
im_c=im;

%bilateral filtering
w=5;
col_quant=5;
sig_d = 3;
sig_r = 0.1;
im_r = im2double(im_c(:,:,1));
im_g = im2double(im_c(:,:,2));
im_b = im2double(im_c(:,:,3));

[X,Y] = meshgrid(-w:w,-w:w);
c = exp(-(X.^2+Y.^2)/(2*sig_d^2));
[m,n] = size(im_r);
B = zeros([m,n]);
for k = 1:1
  for i = 1:m
     for j = 1:n

           i_min = max(i-w,1);
           i_max = min(i+w,m);
           j_min = max(j-w,1);
           j_max = min(j+w,n);
           
           I_r = im_r(i_min:i_max,j_min:j_max);
           I_g = im_g(i_min:i_max,j_min:j_max);
           I_b = im_b(i_min:i_max,j_min:j_max);
           
           H_r = exp(-(I_r-im_r(i,j)).^2/(2*sig_r^2));
           H_g = exp(-(I_g-im_g(i,j)).^2/(2*sig_r^2));
           H_b = exp(-(I_b-im_b(i,j)).^2/(2*sig_r^2));
           
           F_r = H_r.*c((i_min:i_max)-i+w+1,(j_min:j_max)-j+w+1);
           F_g = H_g.*c((i_min:i_max)-i+w+1,(j_min:j_max)-j+w+1);
           F_b = H_b.*c((i_min:i_max)-i+w+1,(j_min:j_max)-j+w+1);
           
           B_r(i,j) = sum(F_r(:).*I_r(:))/sum(F_r(:));
           B_g(i,j) = sum(F_g(:).*I_g(:))/sum(F_g(:));
           B_b(i,j) = sum(F_b(:).*I_b(:))/sum(F_b(:));
           
     end
  end
end
im_bifilt(:,:,1) = B_r;
im_bifilt(:,:,2) = B_g;
im_bifilt(:,:,3) = B_b;

im_bi_q = im_bifilt.*col_quant;
im_bi_q = round(im_bi_q);
im_bi_q = im_bi_q./col_quant;

%edge detection
im = im_bifilt;
if(size(im,3)==3)
    im=rgb2gray(im);
end


gaus_m = fspecial('Gaussian',[7 7],1.6);
im_filt= imfilter(im, gaus_m);

im_filt1= medfilt2(im_filt, [7 7]);


sob_mx= fspecial('sobel');
sob_my= fspecial('sobel');

im_sobx = imfilter(im_filt1, sob_mx);
im_soby = imfilter(im_filt1, sob_my);

im_sob_new = sqrt(im2double(im_sobx.^2+im_soby.^2));
im_sob_grad=atan2(im2double(abs(im_soby)),im2double(abs(im_sobx)))*180/pi;

im_grad_round=im_sob_grad;

if (im_sob_grad>=-22.5 & im_sob_grad<22.5) | (im_sob_grad>=157.5 & im_sob_grad<=180) | (im_sob_grad>=-180 & im_sob_grad<-180+22.5)	
		im_grad_round=0;
	elseif (im_sob_grad>=22.5 & im_sob_grad<67.5) | (im_sob_grad>=-180+22.5 & im_sob_grad<-180+67.5)
		im_grad_round=45;
	elseif (im_sob_grad>=67.5 & im_sob_grad<112.5) | (im_sob_grad>=-180+67.5 & im_sob_grad<-67.5)
		im_grad_round=90;
	elseif (im_sob_grad>=112.5 & im_sob_grad<157.5) | (im_sob_grad>=-67.5 & im_sob_grad<-22.5)
		im_grad_round=135;
end

[m,n]=size(im_grad_round);

im_pad = zeros(size(im_sob_new)+2);
im_pad(2:end-1,2:end-1) = im_sob_new;
im_edge = zeros(size(im_sob_new));

for i=2:m+1
		for j=2:n+1
			if im_grad_round(i-1,j-1)==0
				if im_pad(i,j)>=im_pad(i,j-1) & im_pad(i,j)>=im_pad(i,j+1)
					im_edge(i-1,j-1) = im_pad(i,j);
				end	
			elseif im_grad_round(i-1,j-1)==45
				if im_pad(i,j)>=im_pad(i-1,j+1) & im_pad(i,j)>=im_pad(i+1,j-1)
					im_edge(i-1,j-1) = im_pad(i,j);
				end
			elseif im_grad_round(i-1,j-1)==90
				if im_pad(i,j)>=im_pad(i-1,j) & im_pad(i,j)>=im_pad(i+1,j)
					im_edge(i-1,j-1) = im_pad(i,j);
				end
			else
				if im_pad(i,j)>=im_pad(i-1,j-1) & im_pad(i,j)>=im_pad(i+1,j-1)
					im_edge(i-1,j-1) = im_pad(i,j);
				end
			end	
		end
end

t_high = 0.5;
t_low = 0.2;
im_edge1=im_edge;
for i=1:m
    for j=1:n
        if im_edge(i,j)<t_low
            im_edge1(i,j)=0;
        elseif im_edge(i,j)>=t_high
            im_edge1(i,j) = im_edge(i,j);
        else
            im_edge1(i,j) = t_low;
        end
    end
end

   
for i=1:m
    for j=1:n
        im_edge2(i,j)=im_edge1(i,j);
        if im_edge1(i,j)>0
            im_edge2(i,j)=1;
        else
            im_edge2(i,j)=0;
        end
    end
end

im_edge3 = bwmorph(im_edge2, 'skel', Inf);



%superimposing

im_edge_invert = 1-im_edge3;
im_final(:,:,1) = B_r.*im_edge_invert;
im_final(:,:,2) = B_g.*im_edge_invert;
im_final(:,:,3) = B_b.*im_edge_invert;


imshow(im_c,[]);
figure, imshow(im_edge3,[]);
figure, imshow(im_bifilt,[]);
figure, imshow(im_final,[]);