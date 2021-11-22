clc; clear;
close all;
pkg load image;

% Función para calcular la distancia de Hues
function distance = hue_distance(h0, h1)
    distance = min(abs(h1 - h0), 1 - abs(h1 - h0));
end

% Función que crea la máscara basado en selective color
function [mask, masked_image_rgb] = create_mask(RGB, tolerance)
    % Convierte RGB a HSV
    I = rgb2hsv(RGB);

    hue_reference = 0.55;
    hue_tolerance = tolerance;

    % Crea una máscara basada en la distancia del Hue de referencia con una tolerancia
    mask = (hue_distance(I(:, :, 1), hue_reference) <= hue_tolerance);

    % Inicializar la salida a partir de la imagen
    r n m, op[oiop[[zx chjnmk]]] masked_image = I;

    % Separa el valor de Hue de la imagen
    hues = masked_image(:, :, 1);

    % Pinta el valor de Hue de la imagen en la máscara
    hues(mask) = 0.3;

    % Reemplaza el valor de Hue de la imagen con el valor de Hue de la máscara
    masked_image(:, :, 1) = hues;

    masked_image_rgb = hsv2rgb(masked_image);

end;

% Función que crea los gráficos
function plot_image(h, event)
    global I;
    global tolerance_slider;

    [mask, masked_image_rgb] = create_mask(I, get(tolerance_slider, 'value'));

    subplot(1, 3, 1);
    imshow(I);
    title('Imagen original');

    subplot(1, 3, 2);
    imshow(~mask);
    title(sprintf('Máscara (t = %d)', get(tolerance_slider, 'value')));

    subplot(1, 3, 3);
    imshow(masked_image_rgb);
    title('Imagen con transferencia de color');
end

global I;
global tolerance_slider;

% Leer la imagen
I = imread('blue_wall.jpeg');

% Slider para la tolerancia
tolerance_slider = uicontrol (
'style', 'slider',
'Units', 'normalized',
'position', [0.1, 0.1, 0.8, 0.1],
'min', 0.0,
'max', 0.1,
'value', 0.03,
'callback', {@plot_image}
);

plot_image(0, 0);
