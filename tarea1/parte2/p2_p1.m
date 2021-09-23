clear;
clc;
close all;
pkg load image;

input_img = imread("WingedFigure.jpg");
input_img = input_img(:, :, 1);




[M N] = size(input_img);
rows = floor(M / 4);
cols = floor(N / 4);

rand ("seed", 5);
message_size = floor((rows * cols) / 8);
message = uint8(rand([1 message_size]) * 255);
message_bin = [];

for e = message
    bin_arr = bitget (e, 8: - 1:1);
    message_bin = [message_bin, bin_arr];
endfor

remaining = zeros([1 mod((rows * cols), 8)]);
message_bin = reshape([message_bin, remaining], rows, cols);

T =20;
size(message_bin)
output_img = [];
for x = 1:rows
    new_row = [];
    for y = 1:cols
        Bk = input_img(1 + (4 * (x - 1)):(4 * (x)), 1 + (4 * (y - 1)):(4 * (y)));
        [U, S, V] = svd(Bk);
        if (message_bin(x, y) == 1)
            if (S(3, 3) > (S(2, 2) - S(3, 3)))
                S(4, 4) = S(2, 2) - S(3, 3);
            else
                S(4, 4) = 0;
            endif
            S(2, 2) = S(2, 2) + T;
        endif
        if (S(3, 3) < S(4, 4))
            S(3, 3) = S(4, 4);
        endif
        Bke = U * (S) * V';
        new_row = horzcat(new_row, Bke);
    endfor
    output_img = vertcat(output_img, new_row);
endfor



output_img=uint8(output_img);
subplot(1, 2, 1);
imshow(input_img)
title('Imagen de entrada');

subplot(1, 2, 2);
imshow(output_img)
title('Imagen de salida');

disp("psnr");
disp(psnr(output_img, input_img));

save ("-mat-binary", "output_img.mat", "output_img");
save ("-mat-binary", "message_bin_seed_5.mat", "message_bin");


