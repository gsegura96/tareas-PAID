% Obtener el esqueleto de una imagen binaria

clc; clear; 
close all;
pkg load image;

I_color = imread("WingedFigure.jpg");
A = I_color(:,:,1);
A =im2double(A);



subplot(1,3,1);
imshow(A);
title('Imagen A');


subplot(1,3,2);
imshow(A);
title('Esqueleto')

subplot(1,3,3);
imshow(A);
title('Sobrepuesto')

