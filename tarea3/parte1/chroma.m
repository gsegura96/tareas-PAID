clc; clear;
close all;
pkg load image;
pkg load video

% Función para calcular la distancia de Hues
function distance = hue_distance(h0, h1)
    distance = min(abs(h1 - h0), 1 - abs(h1 - h0));
end

% Función que crea la máscara basado en selective color
function [mask, masked_image_rgb] = create_chroma(bg, fg, tolerance)
    % Convierte RGB a HSV
    fg_hsv = rgb2hsv(fg);

    hue_reference = 0.33;
    hue_tolerance = tolerance;

    % Crea una máscara basada en la distancia del Hue de referencia con una tolerancia
    mask = (hue_distance(fg_hsv(:, :, 1), hue_reference) <= hue_tolerance);
    % Extiende la máscara a 3 canales
    mask_3 = repmat(mask, [1, 1, 3]);

    % Inicializar la salida a partir de la imagen RGB
    masked_image_rgb = fg;

    % Aplica la máscara a la imagen
    masked_image_rgb(mask_3) = bg(mask_3);
end;

% Función que crea los gráficos
function plot_image(fg, mask, masked_image_rgb, frame, frames)
    subplot(1, 3, 1);
    imshow(fg);
    title(sprintf('Imagen original (frame = %i/%i)', frame, frames));

    subplot(1, 3, 2);
    imshow(mask);
    colormap(gca, prism(256)); % Ignore pink map and use jet instead.
    title('Máscara');

    subplot(1, 3, 3);
    imshow(masked_image_rgb);
    title('Imagen con chroma key');
end

% Leer la imagen
bg = imread('breaking.jpeg');

video = VideoReader('green.mp4');
frames = video.NumberOfFrames - 1;

video_bg = VideoReader('globe.mp4');
video_output = VideoWriter('output.mp4');

for i = 1:frames
    fg = readFrame(video);
    % Crear la máscara
    [mask, masked_image_rgb] = create_chroma(readFrame(video_bg), fg, 0.05);

    printf('Procesado frame %i de %i.\n', i, frames);

    % Guardar la imagen
    plot_image(fg, mask, masked_image_rgb, i, frames);
    writeVideo(video_output, masked_image_rgb);
    pause(0.001);
end

close(video_output);
