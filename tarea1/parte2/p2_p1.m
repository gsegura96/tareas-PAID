clear;
clc;
close all;
pkg load image;

rand ("seed", 5);

load barbara_original.mat

size(Ar)

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

T = 0.5;
size(message_bin)
output_img = [];

for x = 1:rows
    new_row = [];
    for y = 1:cols
        Bk = input_img(1 + (4 * (x - 1)):(4 * (x)), 1 + (4 * (y - 1)):(4 * (y)));
        if (message_bin(x, y) == 1)
            [U, S, V] = svd(Bk);
            Sn = S;
         
            Sn(4, 4) = S(2, 2) - S(3, 3);
            if (S(3, 3) < Sn(4, 4))
                Sn(4, 4) = 0;
            endif
            Sn(2, 2) = S(2, 2) + T;
            if (S(3, 3) < S(4, 4))
                Sn(3, 3) = S(4, 4);
            endif
            Bke = U * Sn * V';
            new_row = horzcat(new_row, Bke);
        else
            new_row = horzcat(new_row, Bk);
        endif
     
        ## output_img(1 + (4 * (x - 1)):(4 * (x)), 1 + (4 * (y - 1)):(4 * (y))) = Bk;
    endfor
    output_img = vertcat(output_img, new_row);
endfor

subplot(1, 2, 1);
imshow(input_img)
title('Imagen de entrada');

subplot(1, 2, 2);
imshow(output_img)
title('Imagen de salida');

disp("NPSR");
psnr(input_img - output_img);
disp("NC");
psnr(input_img - output_img);

