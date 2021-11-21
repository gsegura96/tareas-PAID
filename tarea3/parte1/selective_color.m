clc; clear; 
close all;
pkg load image;


% Función para calcular la distancia de Hues
function distance = hue_distance(h0, h1)
    distance = min(abs(h1-h0), 1-abs(h1-h0));
end

function [mask,maskedRGBImage] = create_mask(RGB) 
    % Convierte RGB a HSV
    I = rgb2hsv(RGB);

    hue_reference = 0.0;
    hue_tolerance = 0.03;

    % Crea una máscara basada en la distancia del Hue de referencia con una tolerancia
    mask = ( hue_distance(I(:,:,1), hue_reference) <= hue_tolerance );
    % Extiende la máscara a 3 canales
    mask_3 = repmat(mask, [1, 1, 3]);

    % Crea una versión en escala de grises de la imagen
    gray = rgb2gray(RGB);
    % Extiende escala de grises a 3 canales
    gray_3 = repmat(gray, [1 1 3]);


    % Inicializar la salida a partir de la imagen RGB
    maskedRGBImage = RGB;

    % Aplica la máscara a la imagen
    maskedRGBImage(~mask_3) = gray_3(~mask_3);

end;

I = imread('pencils.jpeg');

[mask,maskedRGBImage] = create_mask(I);

subplot(1,3,1);
imshow(I);
title('Imagen original');

subplot(1,3,2);
imshow(mask);
title('Máscara');

subplot(1,3,3);
imshow(maskedRGBImage);
title('Imagen con selección de color');

