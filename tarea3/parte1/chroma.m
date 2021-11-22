clc; clear;
close all;
pkg load image;

% Función para calcular la distancia de Hues
function distance = hue_distance(h0, h1)
    distance = min(abs(h1 - h0), 1 - abs(h1 - h0));
end

% Función que crea la máscara basado en selective color
function [mask, masked_image_rgb] = create_chroma(bg, fg, tolerance)
    % Convierte RGB a HSV
    fg_hsv = rgb2hsv(fg);

    hue_reference = 0.43;
    hue_tolerance = tolerance;

    % Crea una máscara basada en la distancia del Hue de referencia con una tolerancia
    mask = (hue_distance(fg_hsv(:, :, 1), hue_reference) <= hue_tolerance);
    % Extiende la máscara a 3 canales
    mask_3 = repmat(mask, [1, 1, 3]);

    % Crea una versión en escala de grises de la imagen
    gray = rgb2gray(fg);
    % Extiende escala de grises a 3 canales
    gray_3 = repmat(gray, [1 1 3]);

    % Inicializar la salida a partir de la imagen RGB
    masked_image_rgb = fg;

    % Aplica la máscara a la imagen
    masked_image_rgb(mask_3) = bg(mask_3);
end;

% Función que crea los gráficos
function plot_image(h, event)
    global bg;
    global fg;
    global tolerance_slider;

    [mask, masked_image_rgb] = create_chroma(bg, fg, get(tolerance_slider, 'value'));

    subplot(1, 3, 1);
    imshow(fg);
    title('Imagen original');

    subplot(1, 3, 2);
    imshow(~mask);
    title(sprintf('Máscara (t = %d)', get(tolerance_slider, 'value')));

    subplot(1, 3, 3);
    imshow(masked_image_rgb);
    title('Imagen con chroma key');
end

global bg;
global fg;
global tolerance_slider;

% Leer la imagen
bg = imread('bg.jpeg');
fg = imread('fg.jpeg');

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
